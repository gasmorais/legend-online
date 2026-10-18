package archaeology
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.manager.ArchaeologyManager;
   import yishi.utils.MsgMan;
   
   public class ArchaeologyMakeView extends Component
   {
      
      private var bookBtn:BaseButton;
      
      private var leftView:ArchaeologyMakeLeftView;
      
      private var rightView:ArchaeologyMakeRightView;
      
      private var bookTipView:MovieClip;
      
      public function ArchaeologyMakeView()
      {
         super();
         initView();
         addEvent();
         __updateGoodListHandler("",null);
      }
      
      private function initView() : void
      {
         bookBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyFrame.bookBtn");
         rightView = ComponentFactory.Instance.creatCustomObject("ArchaeologyMakeView.rightView");
         leftView = ComponentFactory.Instance.creatCustomObject("ArchaeologyMakeView.leftView");
         bookTipView = getBtnTipView();
         addChild(bookBtn);
         addChild(leftView);
         addChild(rightView);
         bookBtn.addChild(bookTipView);
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         bookBtn.addEventListener("click",__bookBtnClickHandler);
         MsgMan.addObserver("GOOD_lIST_UPDATE",this,__updateGoodListHandler);
         MsgMan.addObserver("ARCHAEOLOGY_BOOK_DATA",this,__updateGoodListHandler);
      }
      
      private function removeEvent() : void
      {
         bookBtn.removeEventListener("click",__bookBtnClickHandler);
         MsgMan.removeObserver("GOOD_lIST_UPDATE",this,__updateGoodListHandler);
         MsgMan.removeObserver("ARCHAEOLOGY_BOOK_DATA",this,__updateGoodListHandler);
      }
      
      private function __updateGoodListHandler(param1:String, param2:Object) : void
      {
         bookTipView.visible = false;
         if(model.getBookCanComposeCount() > 0)
         {
            bookTipView.visible = true;
            bookTipView.txt.text = model.getBookCanComposeCount().toString();
         }
      }
      
      private function __bookBtnClickHandler(param1:MouseEvent) : void
      {
         if(!DisplayLoader.Context.applicationDomain.hasDefinition("map.campaign.view.house.FurnitureBagCell"))
         {
            LoaderManagerII.instance.load("3.png",3,0,onloadComplete);
         }
         else
         {
            onloadComplete(null,null);
         }
      }
      
      private function onloadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ArchaeologyBookFrame = ComponentFactory.Instance.creatComponentByStylename("archaeology.ArchaeologyBookFrame");
         _loc3_.show();
      }
      
      private function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(bookBtn)
         {
            ObjectUtils.disposeObject(bookBtn);
         }
         bookBtn = null;
         if(leftView)
         {
            ObjectUtils.disposeObject(leftView);
         }
         leftView = null;
         if(rightView)
         {
            ObjectUtils.disposeObject(rightView);
         }
         rightView = null;
         if(bookTipView)
         {
            ObjectUtils.disposeViolentMc(bookTipView);
         }
         bookTipView = null;
         super.dispose();
      }
   }
}

