package consortia.view.newboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaNewBossModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConsortiaNewBossRankRewardTemplateInfo;
   import yishi.datas.templates.ConsortiaNewBossTemplate;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaNewBossCallFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _callBtn:IconButton;
      
      private var _bossNameTxt:FilterFrameText;
      
      private var _winTitleText:FilterFrameText;
      
      private var _lostTitleText:FilterFrameText;
      
      private var _describeTxt:FilterFrameText;
      
      private var _leftCountTxt:FilterFrameText;
      
      private var _winGoodsHbox:HBox;
      
      private var _lostGoodsHbox:HBox;
      
      private var _combox:ComboBox;
      
      private var _bossIcon:BaseIconView;
      
      private var _comboxArr:Array;
      
      private var _index:int;
      
      private var _bossTempInfo:ConsortiaNewBossTemplate;
      
      private var _startIndex:int = 1;
      
      public function ConsortiaNewBossCallFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,432,405);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaNewBossCallFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossCallFrame.bg");
         _callBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossCallFrame.callBtn");
         _winTitleText = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.successTxt");
         _lostTitleText = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.failTxt");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.describeTxt");
         _winGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.successRewardHbox");
         _lostGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.failRewardHbox");
         _combox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.combox");
         _bossNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossCallFrame.bossNameTxt");
         _leftCountTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.leftCountTxt");
         _bossIcon = ComponentFactory.Instance.creatCustomObject("newboss.ConsortiaNewBossFrame.bossIcon");
         addToContent(_bg);
         addToContent(_callBtn);
         _callBtn.y = 235;
         addToContent(_winTitleText);
         _winTitleText.x = 15;
         _winTitleText.y = 128;
         addToContent(_lostTitleText);
         _lostTitleText.x = 30;
         _lostTitleText.y = 173;
         addToContent(_describeTxt);
         _describeTxt.y = 285;
         _describeTxt.x = 20;
         addToContent(_winGoodsHbox);
         _winGoodsHbox.x = 170;
         _winGoodsHbox.y = 100;
         addToContent(_lostGoodsHbox);
         _lostGoodsHbox.x = 170;
         _lostGoodsHbox.y = 145;
         addToContent(_combox);
         _combox.x = 140;
         _combox.y = 70;
         addToContent(_bossNameTxt);
         addToContent(_leftCountTxt);
         _leftCountTxt.x = 130;
         _leftCountTxt.y = 220;
         addToContent(_bossIcon);
         _winTitleText.text = LanguageMgr.GetTranslation("ConsortiaEmeDreamRewardFrame.winTitleText.text");
         _lostTitleText.text = LanguageMgr.GetTranslation("ConsortiaEmeDreamRewardFrame.lostTitleText.text");
         _describeTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossCallFrame.describeTxt");
         refreshComBox();
      }
      
      private function uninit() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_bossNameTxt)
         {
            _bossNameTxt.dispose();
         }
         _bossNameTxt = null;
         if(_callBtn)
         {
            _callBtn.dispose();
         }
         _callBtn = null;
         if(_winTitleText)
         {
            ObjectUtils.disposeObject(_winTitleText);
         }
         _winTitleText = null;
         if(_lostTitleText)
         {
            ObjectUtils.disposeObject(_lostTitleText);
         }
         _lostTitleText = null;
         if(_winGoodsHbox)
         {
            ObjectUtils.disposeAllChildren(_winGoodsHbox);
            ObjectUtils.disposeObject(_winGoodsHbox);
            _winGoodsHbox = null;
         }
         if(_lostGoodsHbox)
         {
            ObjectUtils.disposeAllChildren(_lostGoodsHbox);
            ObjectUtils.disposeObject(_lostGoodsHbox);
            _lostGoodsHbox = null;
         }
         if(_describeTxt)
         {
            _describeTxt.dispose();
         }
         _describeTxt = null;
         if(_combox)
         {
            _combox.dispose();
         }
         _combox = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_callBtn)
         {
            _callBtn.addEventListener("click",__callClickHandler);
         }
         if(_combox)
         {
            _combox.addEventListener("stateChange",__changeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_callBtn)
         {
            _callBtn.removeEventListener("click",__callClickHandler);
         }
         if(_combox)
         {
            _combox.removeEventListener("stateChange",__changeHandler);
         }
      }
      
      private function __callClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(checkTime())
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.resetData");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!consortiaControl.getRightsByIndex(1))
         {
            if(!consortiaControl.getRightsByNum(41))
            {
               _loc2_ = LanguageMgr.GetTranslation("ConsortiaNewBossCallFrame.callTips");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         if(checkScene() && _bossTempInfo)
         {
            ConsortiaNewBossManager.instance.callBOSS(_index + _startIndex);
            dispose();
            FrameControllerManager.instance.openControllerByInfo("consortianewboss",1);
         }
      }
      
      private function get consortiaControl() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = WorldBossHelper.getCampaignTips();
         if(StringHelper.isNullOrEmpty(_loc1_))
         {
            return true;
         }
         MessageTipManager.instance().show(_loc1_);
         return false;
      }
      
      private function get model() : ConsortiaNewBossModel
      {
         return ConsortiaNewBossManager.instance.model;
      }
      
      private function refreshComBox() : void
      {
         var _loc4_:int = 0;
         _comboxArr = [];
         var _loc2_:int = int(model.passLevel + 1 > model.maxLevel ? model.maxLevel : model.passLevel + 1);
         _startIndex = 1;
         _loc4_ = 1;
         while(_loc4_ <= _loc2_)
         {
            _comboxArr.push(LanguageMgr.GetTranslation("public.level2",_loc4_));
            _loc4_++;
         }
         _combox.beginChanges();
         var _loc3_:VectorListModel = _combox.listPanel.vectorListModel;
         _loc3_.clear();
         var _loc1_:int = int(_comboxArr.length);
         _loc4_ = 0;
         while(_loc4_ < _comboxArr.length)
         {
            _loc3_.append(_comboxArr[_loc4_]);
            _loc4_++;
         }
         _combox.listPanel.list.defaultSelectItemByCellValue = _comboxArr[_loc1_ - 1];
         _combox.listPanel.list.scrollToIndex(_loc1_ - 1);
         _combox.listPanel.list.updateListView();
         _combox.commitChanges();
         __changeHandler(null);
      }
      
      private function __changeHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GameHeroTempInfo = null;
         if(_comboxArr && _combox && _combox.textField)
         {
            _index = _comboxArr.indexOf(_combox.textField.text);
            _bossTempInfo = TempleteManager.instance.consortiaNewBossTempCate.getTemplateByLevel(_index + _startIndex);
            if(_bossTempInfo)
            {
               _loc2_ = int(_bossTempInfo.BossId.split(",")[0]);
               _loc3_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc2_);
               if(_loc3_)
               {
                  _bossNameTxt.text = _loc3_.TemplateName;
                  _bossIcon.icon = PathManager.info.ResourcePath + "icon" + _loc3_.Icon;
               }
            }
         }
         refreshRewardView(_index + _startIndex);
      }
      
      private function refreshRewardView(param1:int) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc6_:int = 0;
         var _loc4_:ConsortiaNewBossRankRewardTemplateInfo = null;
         var _loc7_:GoodsInfo = null;
         _winGoodsHbox.removeAllChild();
         _lostGoodsHbox.removeAllChild();
         var _loc5_:Array = TempleteManager.instance.consortiaNewBossRankRewardTempCate.getTemplatesByTypeAndRank(param1,1);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("consortianewboss.ItemBaseItemView");
            _loc4_ = _loc5_[_loc6_];
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc4_.itemId;
            _loc7_.count = _loc4_.count;
            _loc3_.data = _loc7_;
            _winGoodsHbox.addChild(_loc3_);
            _loc6_++;
         }
         var _loc2_:Array = TempleteManager.instance.consortiaNewBossRankRewardTempCate.getTemplatesByTypeAndRank(param1,2);
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("consortianewboss.ItemBaseItemView");
            _loc4_ = _loc2_[_loc6_];
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc4_.itemId;
            _loc7_.count = _loc4_.count;
            _loc3_.data = _loc7_;
            _lostGoodsHbox.addChild(_loc3_);
            _loc6_++;
         }
         _leftCountTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.leftCountTxt2",model.maxCallCount - model.hasCallCount,model.maxCallCount);
      }
      
      private function checkTime() : Boolean
      {
         return false;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               FrameControllerManager.instance.openControllerByInfo("consortianewboss",1);
         }
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

