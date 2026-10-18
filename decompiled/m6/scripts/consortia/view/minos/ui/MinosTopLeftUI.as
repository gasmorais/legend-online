package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MinosManager;
   import mvc.module.minos.MinosModel;
   import yishi.manager.FrameControllerManager;
   
   public class MinosTopLeftUI extends Sprite
   {
      
      protected var _leftInfo:Image;
      
      protected var _topBtn1:BaseButton;
      
      protected var _topBtn2:BaseButton;
      
      protected var _topBtn3:BaseButton;
      
      protected var _topInfoTxt1:FilterFrameText;
      
      public function MinosTopLeftUI()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      protected function initView() : void
      {
         _leftInfo = ComponentFactory.Instance.creatComponentByStylename("ui.minos.leftInfo");
         _topBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.minos.topBtn1");
         _topBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.minos.topBtn2");
         _topBtn3 = ComponentFactory.Instance.creatComponentByStylename("ui.minos.topBtn3");
         _topInfoTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.minos.topInfoTxt1");
         addChild(_leftInfo);
         addChild(_topBtn1);
         addChild(_topBtn2);
         addChild(_topBtn3);
         addChild(_topInfoTxt1);
      }
      
      public function updateView() : void
      {
         if(!model.beginTime)
         {
            return;
         }
         var _loc2_:String = model.beginTime;
         var _loc1_:String = model.endTime;
         _loc2_ = _loc2_.substr(0,10);
         _loc1_ = _loc1_.substr(0,10);
         _topInfoTxt1.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.timeText",_loc2_,_loc1_);
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
      
      private function initEvent() : void
      {
         _topBtn1.addEventListener("click",shopClickhandler);
         _topBtn2.addEventListener("click",gjClickhandler);
         _topBtn3.addEventListener("click",seasonClickhandler);
      }
      
      private function removeEvent() : void
      {
         _topBtn1.removeEventListener("click",shopClickhandler);
         _topBtn2.removeEventListener("click",gjClickhandler);
         _topBtn3.removeEventListener("click",seasonClickhandler);
      }
      
      private function shopClickhandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",2,{"minos":true});
      }
      
      private function gjClickhandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("minos","GJ");
      }
      
      private function seasonClickhandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("minos","SEASON");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftInfo);
         _leftInfo = null;
         ObjectUtils.disposeObject(_topBtn1);
         _topBtn1 = null;
         ObjectUtils.disposeObject(_topBtn2);
         _topBtn2 = null;
         ObjectUtils.disposeObject(_topBtn3);
         _topBtn3 = null;
         ObjectUtils.disposeObject(_topInfoTxt1);
         _topInfoTxt1 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

