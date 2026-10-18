package raveparty
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyModel;
   import utils.LogicUtils;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   
   public class RavePartyView extends Component
   {
      
      private var myScoreImage:Bitmap;
      
      private var myScoreText:FilterFrameText;
      
      private var activeAlertText:FilterFrameText;
      
      private var moreSeeText:FilterFrameText;
      
      private var linkText:FilterFrameText;
      
      private var vbox:VBox;
      
      private var itemList:Vector.<RavePartyItemView>;
      
      public function RavePartyView()
      {
         super();
         initView();
         initItemListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         myScoreImage = ComponentFactory.Instance.creatBitmap("asset.RavePartyView.myScoreImage");
         myScoreText = ComponentFactory.Instance.creatComponentByStylename("RavePartyView.myScoreText");
         activeAlertText = ComponentFactory.Instance.creatComponentByStylename("RavePartyView.activeAlertText");
         moreSeeText = ComponentFactory.Instance.creatComponentByStylename("RavePartyView.moreSeeText");
         linkText = ComponentFactory.Instance.creatComponentByStylename("RavePartyView.linkText");
         vbox = ComponentFactory.Instance.creatComponentByStylename("RavePartyView.vbox");
         addChild(myScoreImage);
         addChild(myScoreText);
         addChild(activeAlertText);
         addChild(moreSeeText);
         addChild(linkText);
         addChild(vbox);
         activeAlertText.text = LanguageMgr.GetTranslation("RavePartyView.activeAlertText.text");
         moreSeeText.text = LanguageMgr.GetTranslation("RavePartyView.moreSeeText.text");
         linkText.htmlText = LanguageMgr.GetTranslation("RavePartyView.linkText.text");
         linkText.mouseEnabled = true;
      }
      
      private function initItemListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RavePartyItemView = null;
         itemList = new Vector.<RavePartyItemView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new RavePartyItemView(_loc2_ + 1);
            vbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("RAVE_PARTY_TEMP_UPDTAE",this,__updateRavePartyInfoHandler);
         MsgMan.addObserver("RAVE_PARTY_USERINFO_UPDTAE",this,__updateRavePartyInfoHandler);
         linkText.addEventListener("click",__linkCilckHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("RAVE_PARTY_TEMP_UPDTAE",this,__updateRavePartyInfoHandler);
         MsgMan.removeObserver("RAVE_PARTY_USERINFO_UPDTAE",this,__updateRavePartyInfoHandler);
         if(linkText)
         {
            linkText.removeEventListener("click",__linkCilckHandler);
         }
      }
      
      private function __updateRavePartyInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __linkCilckHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("funny");
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RavePartyItemView = null;
         myScoreText.text = model.myTotalScore + "";
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new RavePartyItemView(_loc2_ + 1);
               itemList[_loc2_] = _loc1_;
            }
            _loc1_.refreshView();
            _loc2_++;
         }
      }
      
      private function get model() : RavePartyModel
      {
         return RavePartyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(myScoreImage)
         {
            ObjectUtils.disposeObject(myScoreImage);
         }
         myScoreImage = null;
         if(myScoreText)
         {
            ObjectUtils.disposeObject(myScoreText);
         }
         myScoreText = null;
         if(activeAlertText)
         {
            ObjectUtils.disposeObject(activeAlertText);
         }
         activeAlertText = null;
         if(moreSeeText)
         {
            ObjectUtils.disposeObject(moreSeeText);
         }
         moreSeeText = null;
         if(linkText)
         {
            ObjectUtils.disposeObject(linkText);
         }
         linkText = null;
         if(vbox)
         {
            ObjectUtils.disposeObject(vbox);
         }
         vbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         super.dispose();
      }
   }
}

