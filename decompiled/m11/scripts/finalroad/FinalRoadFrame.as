package finalroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.finalroad.FinalRoadModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class FinalRoadFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _titleTxt:GradientText;
      
      private var _descTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _panel:HRollItemPanel;
      
      private var _itemList:Array = [];
      
      private var _point:int;
      
      private var _helpBtn:BaseButton;
      
      public function FinalRoadFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,900,655);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("finalRoadFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.finalRoadFrame.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("finalRoadFrame.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("finalRoadFrame.descTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("finalRoadFrame.numTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadFrame.buyBtn");
         _panel = new HRollItemPanel();
         _panel.initParams("finalRoadFrame.itemBoxs","finalRoadFrame.leftBtn","finalRoadFrame.rightBtn",3,190,375);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadFrame.helpBtn");
         addToContent(_bg);
         addToContent(_titleTxt);
         addToContent(_descTxt);
         addToContent(_numTxt);
         addToContent(_panel);
         addToContent(_buyBtn);
         addToContent(_helpBtn);
         _titleTxt.text = LanguageMgr.GetTranslation("finalRoadFrame.titleTxt.text");
         var _loc1_:Array = ConfigInfoManager.instance.getFinalRoadRefreshTime();
         var _loc4_:String = LanguageMgr.GetTranslation("secret.day.tip");
         var _loc5_:Array = _loc4_.split(",");
         var _loc2_:int = int(_loc1_[0]);
         var _loc3_:Array = _loc1_[1].split("|");
         _descTxt.text = LanguageMgr.GetTranslation("finalRoadFrame.resetTime",_loc5_[_loc2_],_loc3_[0]);
         initItems();
      }
      
      private function initItems() : void
      {
         var _loc1_:FinalRoadItem = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(TempleteManager.instance.finalRoadChapterTempCate.getChapterCount());
         _loc3_ = 1;
         while(_loc3_ <= _loc2_)
         {
            _loc1_ = new FinalRoadItem(_loc3_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _panel.updateList(_itemList);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         MsgMan.addObserver("FINALROAD_CHALLENGE",this,__finalRoadChallengeHandler);
         MsgMan.addObserver("FINALROAD_CHAPTER_UPDATE",this,__finalRoadChapterHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         MsgMan.removeObserver("FINALROAD_CHALLENGE",this,__finalRoadChallengeHandler);
         MsgMan.removeObserver("FINALROAD_CHAPTER_UPDATE",this,__finalRoadChapterHandler);
         _helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("finalRoadFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = ConfigInfoManager.instance.getFinalRoadChallengePrice();
         if(_loc2_[model.buyChapterTimes])
         {
            _point = _loc2_[model.buyChapterTimes];
         }
         if(_point == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoadFrame.buy.maxText"));
            return;
         }
         var _loc4_:int = 1;
         var _loc5_:int = _loc2_.length - model.buyChapterTimes;
         var _loc3_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc6_:String = LanguageMgr.GetTranslation("finalRoadFrame.TodayNotAlert.content.text",_point,_loc4_,_loc5_);
         SharedManagerHelper.ins.needAlert("finalroad.FinalRoadFrame.buyClick",buyCallBack,_loc3_,_loc6_);
      }
      
      private function buyCallBack() : void
      {
         if(playerInfo.point < _point)
         {
            RechargeAlertMannager.show();
            return;
         }
         FinalRoadManager.instance.send(0);
      }
      
      private function __finalRoadChallengeHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __finalRoadChapterHandler(param1:String, param2:Object) : void
      {
         if(!model.isOpen)
         {
            dispose();
            return;
         }
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FinalRoadItem = null;
         _numTxt.text = LanguageMgr.GetTranslation("finalRoadFrame.numTxt.text",model.surplusChapterTimes);
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.refreshView();
            _loc2_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : FinalRoadModel
      {
         return FinalRoadManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

