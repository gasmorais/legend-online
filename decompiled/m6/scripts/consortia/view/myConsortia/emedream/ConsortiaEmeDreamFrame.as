package consortia.view.myConsortia.emedream
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import managers.MopupManager;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConsortiaBossTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaEmeDreamFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _upBtn:IconButton;
      
      private var _callBtn:IconButton;
      
      private var _winTitleText:FilterFrameText;
      
      private var _lostTitleText:FilterFrameText;
      
      private var _describeTxt:FilterFrameText;
      
      private var _winGoodsHbox:HBox;
      
      private var _lostGoodsHbox:HBox;
      
      private var _combox:ComboBox;
      
      private var _helpBtn:BaseButton;
      
      private var _comboxArr:Array;
      
      public function ConsortiaEmeDreamFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,422,280);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.bg");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.upBtn");
         _callBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.callBtn");
         _winTitleText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.winTitleText");
         _lostTitleText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.lostTitleText");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.describeTxt");
         _winGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.winGoodsHbox");
         _lostGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.lostGoodsHbox");
         _combox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.combox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossFrame.helpBtn");
         addToContent(_bg);
         addToContent(_upBtn);
         addToContent(_callBtn);
         addToContent(_winTitleText);
         addToContent(_lostTitleText);
         addToContent(_describeTxt);
         addToContent(_winGoodsHbox);
         addToContent(_lostGoodsHbox);
         addToContent(_combox);
         addToContent(_helpBtn);
         _winTitleText.text = LanguageMgr.GetTranslation("ConsortiaEmeDreamRewardFrame.winTitleText.text");
         _lostTitleText.text = LanguageMgr.GetTranslation("ConsortiaEmeDreamRewardFrame.lostTitleText.text");
         _describeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.describeTxt");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         __updateHandler(null);
      }
      
      private function refreshComBox() : void
      {
         var _loc3_:int = 0;
         _comboxArr = [];
         _loc3_ = 1;
         while(_loc3_ <= 10)
         {
            _comboxArr.push(LanguageMgr.GetTranslation("public.level2",_loc3_));
            _loc3_++;
         }
         _combox.beginChanges();
         var _loc2_:VectorListModel = _combox.listPanel.vectorListModel;
         _loc2_.clear();
         var _loc1_:int = int(model.emeDreamInfo.grade > 10 ? 10 : model.emeDreamInfo.grade);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_.append(_comboxArr[_loc3_]);
            _loc3_++;
         }
         _combox.listPanel.list.updateListView();
         _combox.commitChanges();
         _combox.listPanel.list.defaultSelectItemByCellValue = _comboxArr[_loc1_ - 1];
         __changeHandler(null);
      }
      
      private function uninit() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_upBtn)
         {
            _upBtn.dispose();
         }
         _upBtn = null;
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
         if(_upBtn)
         {
            _upBtn.addEventListener("click",__upClickHandler);
         }
         if(_callBtn)
         {
            _callBtn.addEventListener("click",__callClickHandler);
         }
         if(_combox)
         {
            _combox.addEventListener("stateChange",__changeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__onHelperBtnClick);
         }
         ConsortiaManager.instance.model.addEventListener("UPDA_CONSORTIA_INFO",__updateHandler);
         MsgMan.addObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__switchHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upClickHandler);
         }
         if(_callBtn)
         {
            _callBtn.removeEventListener("click",__callClickHandler);
         }
         if(_combox)
         {
            _combox.removeEventListener("stateChange",__changeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__onHelperBtnClick);
         }
         ConsortiaManager.instance.model.removeEventListener("UPDA_CONSORTIA_INFO",__updateHandler);
         MsgMan.removeObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__switchHandler);
      }
      
      private function __switchHandler(param1:String, param2:Object) : void
      {
         if(model.emeDreamInfo.state == 1)
         {
            FrameControllerManager.instance.openControllerByInfo("consortia",1);
         }
      }
      
      private function __changeHandler(param1:InteractiveEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:int = 0;
         if(_comboxArr && _combox && _combox.textField)
         {
            _loc3_ = _comboxArr.indexOf(_combox.textField.text);
            if(_loc3_ + 1 == model.emeDreamInfo.grade)
            {
               _upBtn.enable = true;
            }
            else
            {
               _upBtn.enable = false;
            }
            _loc5_ = TempleteManager.instance.getTemplatesByType(42);
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               if(_loc3_ + 1 == _loc5_[_loc4_].Grades)
               {
                  _loc2_ = int(_loc5_[_loc4_].TemplateId);
                  break;
               }
               _loc4_++;
            }
            _callBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.upGradeBtnTip2",_loc2_);
         }
         refreshRewardView(_loc3_ + 1);
      }
      
      private function refreshRewardView(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc15_:Array = null;
         var _loc12_:GoodsTemplateInfo = null;
         var _loc8_:BaseItemView = null;
         var _loc14_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc9_:Array = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc16_:GoodsInfo = null;
         _winGoodsHbox.removeAllChild();
         _lostGoodsHbox.removeAllChild();
         var _loc10_:ConsortiaBossTemplateInfo = TempleteManager.instance.consortiaBossTemplateCate.getTemplateByLevel(param1);
         if(!_loc10_)
         {
            return;
         }
         var _loc11_:Array = _loc10_.WinReward.split("|");
         var _loc5_:Array = _loc10_.LostReward.split("|");
         var _loc13_:int = int(_loc11_.length);
         var _loc3_:int = int(_loc5_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc13_)
         {
            _loc15_ = _loc11_[_loc6_].split(",");
            _loc12_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc15_[0]);
            if(_loc12_)
            {
               _loc8_ = ComponentFactory.Instance.creatCustomObject("ConsortiaBossFrame.baseItem");
               _loc14_ = new GoodsInfo();
               _loc14_.templateId = _loc15_[0];
               _loc14_.count = _loc15_[1];
               _loc8_.data = _loc14_;
               _winGoodsHbox.addChild(_loc8_);
            }
            _loc6_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc9_ = _loc5_[_loc7_].split(",");
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc9_[0]);
            if(_loc4_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ConsortiaBossFrame.baseItem");
               _loc16_ = new GoodsInfo();
               _loc16_.templateId = _loc9_[0];
               _loc16_.count = _loc9_[1];
               _loc2_.data = _loc16_;
               _lostGoodsHbox.addChild(_loc2_);
            }
            _loc7_++;
         }
      }
      
      private function __updateHandler(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         refreshComBox();
         var _loc4_:Array = TempleteManager.instance.getTemplatesByType(42);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(model.emeDreamInfo.grade + 1 == _loc4_[_loc3_].Grades)
            {
               _loc2_ = int(_loc4_[_loc3_].Data);
               break;
            }
            _loc3_++;
         }
         if(model.emeDreamInfo.grade >= 10)
         {
            _upBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.upGradeTip1");
         }
         else
         {
            _upBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.upGradeBtnTip1",_loc2_);
         }
      }
      
      private function __upClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(model.emeDreamInfo.grade >= 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.upGradeTip1"));
            return;
         }
         var _loc4_:Array = TempleteManager.instance.getTemplatesByType(42);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(model.emeDreamInfo.grade + 1 == _loc4_[_loc3_].Grades)
            {
               _loc2_ = int(_loc4_[_loc3_].Data);
               break;
            }
            _loc3_++;
         }
         if(model.emeDreamInfo.spirit < _loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.upGradeTip2"));
            return;
         }
         ConsortiaSocketOutManager.upgradeConsortiaBoss();
      }
      
      private function checkTime() : Boolean
      {
         var _loc1_:Boolean = false;
         if(playerModel.sysCurtime.hours == 23 && playerModel.sysCurtime.minutes >= 20)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __callClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Array = null;
         var _loc5_:int = 0;
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
         if(model.emeDreamInfo.state != 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt" + model.emeDreamInfo.state);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_comboxArr && _combox && _combox.textField)
         {
            _loc4_ = _comboxArr.indexOf(_combox.textField.text);
            _loc6_ = TempleteManager.instance.getTemplatesByType(42);
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               if(_loc4_ + 1 == _loc6_[_loc5_].Grades)
               {
                  _loc3_ = int(_loc6_[_loc5_].TemplateId);
                  break;
               }
               _loc5_++;
            }
            if(model.consortiaInfo.offer < _loc3_)
            {
               ConsortiaSkillHelper.addWealth();
               return;
            }
            if(checkScene() && _loc4_ >= 0)
            {
               ConsortiaSocketOutManager.callConsortiaBoss(_loc4_ + 1);
            }
         }
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
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaEmeDreamHelperFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               FrameControllerManager.instance.openControllerByInfo("consortia",1,5);
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
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

