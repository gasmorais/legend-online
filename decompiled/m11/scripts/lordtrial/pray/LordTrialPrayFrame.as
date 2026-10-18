package lordtrial.pray
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.LordTrialEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.lordtrial.LordTrialModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.LordTrialManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class LordTrialPrayFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _prayNumTxt:FilterFrameText;
      
      private var _sacrificeNumTxt:FilterFrameText;
      
      private var _prayDescTxt:FilterFrameText;
      
      private var _sacrificeDescTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _startPrayBtn:IconButton;
      
      private var _endPrayBtn:IconButton;
      
      private var _continueSacriBtn:IconButton;
      
      private var _canGetGoodsHBox:HBox;
      
      private var _totalPrayCount:int;
      
      private var _totalSacNum:int;
      
      private var _leftPrayNum:int = 12;
      
      private var _leftSacNum:int = 14;
      
      private var _model:LordTrialModel;
      
      public function LordTrialPrayFrame()
      {
         super();
         _model = LordTrialManager.instance.model;
         initView();
         addEvent();
         __updateViewHandler(null);
      }
      
      private function initView() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:LordTrialPrayCardItem = null;
         var _loc4_:int = 0;
         titleText = LanguageMgr.GetTranslation("lordtrial.pray.LordTrialPrayFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.bg");
         _prayNumTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.prayNumTxt");
         _sacrificeNumTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.sacrificeNumTxt");
         _prayDescTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.prayDescTxt");
         _sacrificeDescTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.sacrificeDescTxt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.hBox");
         _startPrayBtn = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.startPrayBtn");
         _endPrayBtn = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.endPrayBtn");
         _continueSacriBtn = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.continueSacriBtn");
         _canGetGoodsHBox = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayFrame.canGetGoodsHBox");
         addToContent(_bg);
         addToContent(_prayNumTxt);
         addToContent(_sacrificeNumTxt);
         addToContent(_prayDescTxt);
         addToContent(_sacrificeDescTxt);
         addToContent(_hBox);
         addToContent(_startPrayBtn);
         addToContent(_endPrayBtn);
         addToContent(_continueSacriBtn);
         addToContent(_canGetGoodsHBox);
         _prayDescTxt.text = LanguageMgr.GetTranslation("lordtrial.pray.lordTrialPrayFrame.prayDescTxt");
         _sacrificeDescTxt.text = LanguageMgr.GetTranslation("lordtrial.pray.lordTrialPrayFrame.sacrificeDescTxt");
         if(TempleteManager.instance.getConfigInfoByConfigName("lord_trial_pray_templates"))
         {
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("lord_trial_pray_templates").ConfigValue;
            if(_loc1_)
            {
               _loc2_ = _loc1_.split(",");
               if(_loc2_)
               {
                  if(_loc2_[0])
                  {
                     _totalPrayCount = _loc2_[0];
                  }
                  if(_loc2_[1])
                  {
                     _totalSacNum = _loc2_[1];
                  }
               }
            }
         }
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc3_ = new LordTrialPrayCardItem();
            _hBox.addChild(_loc3_);
            _loc4_++;
         }
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_prayNumTxt);
         _prayNumTxt = null;
         ObjectUtils.disposeObject(_sacrificeNumTxt);
         _sacrificeNumTxt = null;
         ObjectUtils.disposeObject(_prayDescTxt);
         _prayDescTxt = null;
         ObjectUtils.disposeObject(_sacrificeDescTxt);
         _sacrificeDescTxt = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_startPrayBtn);
         _startPrayBtn = null;
         ObjectUtils.disposeObject(_endPrayBtn);
         _endPrayBtn = null;
         ObjectUtils.disposeObject(_continueSacriBtn);
         _continueSacriBtn = null;
         ObjectUtils.disposeObject(_canGetGoodsHBox);
         _canGetGoodsHBox = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_startPrayBtn)
         {
            _startPrayBtn.addEventListener("click",__startPrayBtnHandler);
         }
         if(_endPrayBtn)
         {
            _endPrayBtn.addEventListener("click",__endPrayBtnHandler);
         }
         if(_continueSacriBtn)
         {
            _continueSacriBtn.addEventListener("click",__continueSacriBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_VIEW",__updateViewHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_startPrayBtn)
         {
            _startPrayBtn.removeEventListener("click",__startPrayBtnHandler);
         }
         if(_endPrayBtn)
         {
            _endPrayBtn.removeEventListener("click",__endPrayBtnHandler);
         }
         if(_continueSacriBtn)
         {
            _continueSacriBtn.removeEventListener("click",__continueSacriBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_VIEW",__updateViewHandler);
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
      
      private function __startPrayBtnHandler(param1:MouseEvent) : void
      {
         if(_totalPrayCount - playerInfo.prayCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.pray.countNotEnlogh"));
            return;
         }
         LordTrialManager.startPray();
      }
      
      private function __endPrayBtnHandler(param1:MouseEvent) : void
      {
         LordTrialManager.endPray();
         dispose();
      }
      
      private function __continueSacriBtnHandler(param1:MouseEvent) : void
      {
         if(_totalSacNum - playerInfo.sacrificeCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.pray.sacNotEnlogh"));
            return;
         }
         if(playerInfo.lordTrialCard.indexOf("0") == -1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.pray.notNull"));
            return;
         }
         LordTrialManager.sacrifice();
      }
      
      private function __updateViewHandler(param1:LordTrialEvent) : void
      {
         var _loc2_:LordTrialPrayCardItem = null;
         var _loc7_:int = 0;
         var _loc5_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         var _loc11_:Array = null;
         var _loc3_:String = null;
         var _loc9_:String = null;
         var _loc4_:Array = null;
         var _loc10_:Array = null;
         var _loc6_:int = 0;
         var _loc12_:String = null;
         _prayNumTxt.text = (_totalPrayCount - playerInfo.prayCount).toString();
         _sacrificeNumTxt.text = (_totalSacNum - playerInfo.sacrificeCount).toString();
         if(playerInfo.prayStatus == 0)
         {
            _startPrayBtn.visible = true;
            _endPrayBtn.visible = false;
            _continueSacriBtn.visible = false;
            if(_canGetGoodsHBox)
            {
               _canGetGoodsHBox.removeAllChild();
            }
         }
         else if(playerInfo.prayStatus == 1)
         {
            _startPrayBtn.visible = false;
            _endPrayBtn.visible = true;
            _continueSacriBtn.visible = true;
            if(_canGetGoodsHBox)
            {
               _canGetGoodsHBox.removeAllChild();
            }
            _loc7_ = 0;
            while(_loc7_ < 5)
            {
               _loc2_ = _hBox.getChildAt(_loc7_) as LordTrialPrayCardItem;
               if(_loc2_)
               {
                  _loc2_.openStatus = playerInfo.lordTrialCard.split(",")[_loc7_];
               }
               _loc7_++;
            }
            _loc6_ = getCardCount();
            _loc12_ = TempleteManager.instance.lordTrialTempCate.getPrayItems(_loc6_);
            if(_loc12_)
            {
               _loc11_ = _loc12_.split("|");
               if(_loc11_)
               {
                  _loc3_ = _loc11_[0];
                  _loc9_ = _loc11_[1];
               }
               if(_loc3_)
               {
                  _loc4_ = _loc3_.split(",");
               }
               if(_loc9_)
               {
                  _loc10_ = _loc9_.split(",");
               }
            }
            if(_loc4_)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_.length)
               {
                  _loc8_ = new GoodsInfo();
                  _loc5_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
                  _loc8_.templateId = _loc4_[_loc7_];
                  _loc8_.count = _loc10_[_loc7_];
                  _loc5_.data = _loc8_;
                  _canGetGoodsHBox.addChild(_loc5_);
                  _loc7_++;
               }
            }
         }
      }
      
      private function getCardCount() : int
      {
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:String = playerInfo.lordTrialCard;
         if(_loc2_)
         {
            _loc1_ = _loc2_.split(",");
            if(_loc1_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc1_.length)
               {
                  if(_loc1_[_loc4_] == 1)
                  {
                     _loc3_++;
                  }
                  _loc4_++;
               }
            }
         }
         return _loc3_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      public function show(param1:int = 0) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

