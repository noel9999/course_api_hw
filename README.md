# README

## 我們該如何執行這個 server
  1. 取得所有課程列表
     GET https://fierce-peak-05253.herokuapp.com/api/courses.json
  2. 建立課程
     POST https://fierce-peak-05253.herokuapp.com/api/courses.json
     參數範例，以 json 格式做示範
     ```json
     {
        "title": "Spider Man No way home",
        "mentor_title": "u r not that amazing",
        "description": "@_@",
        "chapters_attributes": [
          {
            "title": "original",
            "order": 0,
            "lessons_attributes": [
              {
                "title": "episode1",
                "content": "ContentContentContent",
                "order": 3
              },
              {
                "title": "episode2",
                "content": "ContentContentContent",
                "order": 2
              }
            ]
          }
        ]
      }
     ```
  3. 更新/刪除/觀看單一課程
    提供 POSTMAN 的使用範例，存放再 onedrive 的 [下載連結](https://1drv.ms/u/s!Ag6_wvstaX3qgooDOOIiPXqRXyttUQ?e=fV7Tcz)
## 專案的架構，API server 的架構邏輯

   此專案是以 Rails API only 規格建立減少不必要的元件。 API 的路由有預留版本號的彈性，未來如有新增版本號需求可透過 rails routing constraints 來達成 mapping
## 你對於使用到的第三方 Gem 的理解，以及他們的功能簡介
   此專案功能與規劃尚小，功能上暫無使用第三方的 GEM ，僅使用 kaminari 來替 model 做分頁管理以避免一次撈太多資料。其他使用的 GEM 都是支援撰寫 RSPEC 方便
## 你在程式碼中寫註解的原則，遇到什麼狀況會寫註解

   個人寫註解的原則通常針對
    1. 不直覺的寫法或調用、較為特別的處理
    2. 未來可能的影響
   其中在 models/course.rb chapter.rb 以及 api/v1/controllers/courses_controller.rb 中的 update 有加入些許註解
## 當有多種實作方式時，請說明為什麼你會選擇此種方式

  以此專案的一次性建立多層關聯物件為例，也可透過建立 form_object 或 service_object 來幫助自己實現一次性寫入，並把邏輯獨立出 model 來，減少潛在影響、在未來可能的需求彈性上也更為良好、也方便測試。然而 rails 有提供 accepts_nested_attributes_for 來達到一次性寫入關連物件，並且在建立、刪除、修改都相當方便，缺點是寫入的參數名有特定規則，當做 API 參數時需要跟前端溝通好，以及在特殊要求上的實現較為困難，兩者個有利弊 ~ZB~ ，但當功能尚小時未減少過多當下還不必要的設計，所以採取此方法。
## 在這份專案中你遇到的困難、問題，以及解決的方法

  1. 一次性寫入多階層資料時，在預想邏輯上，應該是所有階層的資料都合法時，才一次性寫入，當有任一從屬資料不合法時，則整份資料都不該被寫入，以維持使用者操作情境單純。當配合 accepts_nested_attributes_for 時，則需要在 parent model 層也增加從屬資料的驗證，但潛在影響是這個驗證未來 model 變大時可能會影響到其他操作或增加操作成本，未來 model 變大時，可以把用來針對 API 專門建立與編輯時的驗證與相關邏輯獨立出去成 form object ，model 層僅保有基本的驗證即可。
  2. 排序功能本考慮過使用 acts_as_list ，但因為前後端分離的情境，以及使用者可能輸入的 order 的內容與情境實在太多，例如可能全部都輸入一樣的數字、或是數字不連貫、突然寫入一個很大的數字等等。所以最後決定不針對使用者輸入的數字去做任何後續處理，僅限制輸入為非負整數，然後搭配 id 一同對關聯資料做 order by asc 排序，再端看前端看如何使用此值去排序，溝通好就好。另因為 order 僅針對特地課程的章節或單元做排序，影響資料小，所以不額外建立 index。
