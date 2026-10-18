package armyII.viewII.talent
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TalentEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.FormularySets;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.NewKingContractView;
   import yishi.view.tips.MessageTipManager;
   
   public class TalentView extends Sprite implements Disposeable
   {
      
      public static const STEP:Number = 9999999;
      
      private var _back:Bitmap;
      
      private var _advBack:Bitmap;
      
      private var _pointBm:Bitmap;
      
      private var _washBtn:BaseButton;
      
      private var _remainPointTxt:FilterFrameText;
      
      private var _talentLevelTxt:FilterFrameText;
      
      private var _arrows:Sprite;
      
      private var _arrowDic:Dictionary;
      
      private var _container:Component;
      
      private var _advancedContainer:Component;
      
      private var _skillDic:Dictionary;
      
      private var _advSkillDic:Dictionary;
      
      private var _filter:IFilterFormat;
      
      private var _levelFlagBm:Bitmap;
      
      private var _talentLvBg:Bitmap;
      
      private var _talentLvMv:MovieClip;
      
      private var _levelUpUse:Bitmap;
      
      private var _currentHave:Bitmap;
      
      private var _useShowBg:Bitmap;
      
      private var _useShowBg02:Bitmap;
      
      private var _coinView:Bitmap;
      
      private var _expView:Bitmap;
      
      private var _coinView02:Bitmap;
      
      private var _expView02:Bitmap;
      
      private var _levelUpCoinTxt:FilterFrameText;
      
      private var _levelUpExpTxt:FilterFrameText;
      
      private var _curCoinTxt:FilterFrameText;
      
      private var _curExpTxt:FilterFrameText;
      
      private var _currentHaveTxtNote:FilterFrameText;
      
      private var _useShowBg03:Bitmap;
      
      private var _stoneBmd:Bitmap;
      
      private var _currentHaveStoneTxt:FilterFrameText;
      
      private var _numBit:BitmapData;
      
      private var _nextLevelNeedCoin:int;
      
      private var _nextLevelExp:int;
      
      private var _newKingContract:NewKingContractView;
      
      private var _upGrade:BaseButton;
      
      private const GAP_X:Number = 122;
      
      private const GAP_Y:Number = 106;
      
      private var _siteArr:Array = [[165,82],[226.25,224.8],[304.8,146.25],[303.8,25.7],[226.25,-54.8],[116.7,-54.8],[27.15,24.7],[27.15,146.25],[116.7,224.8]];
      
      private var _advSiteArr:Array = [[164,-55],[293.25,46.25],[249.8,196.7],[89.8,199.25],[32.25,43.8]];
      
      public function TalentView()
      {
         super();
         _filter = new UIFilter();
         initView();
         refreshData();
         addEvent();
         refreshTalentSkill();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("army.talent.BackBmdBG");
         addChild(_back);
         _back.visible = true;
         _advBack = ComponentFactory.Instance.creatBitmap("asset.army.talentAdvanced.Bg");
         addChild(_advBack);
         _advBack.visible = false;
         _pointBm = ComponentFactory.Instance.creatBitmap("army.talent.TalentPointBmd");
         addChild(_pointBm);
         _washBtn = ComponentFactory.Instance.creatComponentByStylename("army.talent.WashBtn");
         addChild(_washBtn);
         _newKingContract = new NewKingContractView();
         _newKingContract.x = 50;
         _newKingContract.y = 381;
         addChild(_newKingContract);
         _remainPointTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.RemainTalentPointTxt");
         _remainPointTxt.text = "100";
         addChild(_remainPointTxt);
         _talentLvBg = ComponentFactory.Instance.creatBitmap("army.talent.GradeBack");
         addChild(_talentLvBg);
         _talentLvMv = ComponentFactory.Instance.creat("army.talent.TalentLvView");
         addChild(_talentLvMv);
         _levelUpUse = ComponentFactory.Instance.creatBitmap("army.talent.GradeUpUse");
         _currentHave = ComponentFactory.Instance.creatBitmap("army.talent.CurrentHave");
         _useShowBg = ComponentFactory.Instance.creatBitmap("army.talent.ShowBG");
         _useShowBg02 = new Bitmap(_useShowBg.bitmapData.clone());
         _useShowBg02.x = 490;
         _useShowBg02.y = 235;
         addChild(_levelUpUse);
         addChild(_currentHave);
         addChild(_useShowBg);
         addChild(_useShowBg02);
         _coinView = ComponentFactory.Instance.creatBitmap("army.talent.CoinBmd");
         _expView = ComponentFactory.Instance.creatBitmap("army.talent.EXPBmd");
         _coinView02 = new Bitmap(_coinView.bitmapData.clone());
         _coinView02.y = 191;
         _expView02 = new Bitmap(_expView.bitmapData.clone());
         _coinView02.x = _expView02.x = 497;
         _expView02.y = 244;
         addChild(_coinView);
         addChild(_expView);
         addChild(_coinView02);
         addChild(_expView02);
         _levelUpCoinTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.GradeUpExpendTxt");
         _levelUpExpTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.GradeUpExpendTxt");
         _levelUpExpTxt.y = 110;
         _curCoinTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.CurrentHaveTxt");
         _curExpTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.CurrentHaveTxt");
         _curExpTxt.y = 241;
         _currentHaveTxtNote = ComponentFactory.Instance.creatComponentByStylename("army.talent.CurrentHaveTxtNote");
         _useShowBg03 = new Bitmap(_useShowBg.bitmapData.clone());
         _useShowBg03.x = 490;
         _useShowBg03.y = 280;
         _stoneBmd = ComponentFactory.Instance.creatBitmap("army.talent.StoneBmd");
         _currentHaveStoneTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.CurrentHaveStoneTxt");
         addChild(_levelUpCoinTxt);
         addChild(_levelUpExpTxt);
         addChild(_curCoinTxt);
         addChild(_curExpTxt);
         addChild(_currentHaveTxtNote);
         addChild(_useShowBg03);
         addChild(_stoneBmd);
         addChild(_currentHaveStoneTxt);
         _upGrade = ComponentFactory.Instance.creatComponentByStylename("armyII.upgradeButton");
         _upGrade.x = 510;
         _upGrade.y = 322;
         addChild(_upGrade);
         _container = ComponentFactory.Instance.creatComponentByStylename("army.talent.TileContainer");
         addChild(_container);
         _container.visible = true;
         _advancedContainer = ComponentFactory.Instance.creatComponentByStylename("army.talent.advTileContainer");
         addChild(_advancedContainer);
         _advancedContainer.visible = false;
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.core.PawnLevelNum_1").clone();
         var _loc1_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(212012).TemplateName;
         _currentHaveTxtNote.text = LanguageMgr.GetTranslation("armyII.viewII.talent.currentHaveTxtNote",_loc1_);
         initSkillList();
         initAdvSkillList();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("TALENT_UPGRADE",__talenChangeHanler);
         NotificationManager.instance.addEventListener("TALENT_RESET",__talenChangeHanler);
         _washBtn.addEventListener("click",__washPoint);
         _upGrade.addEventListener("click",__upGrade);
         NotificationManager.instance.addEventListener("CHANGETALENTVIEW",changeTalent);
      }
      
      protected function __talenChangeHanler(param1:NotificationEvent) : void
      {
         if(TalentTabBtnView.SELECTEDINDEX == 0)
         {
            refreshTalentSkill();
            refreshData();
         }
         else
         {
            refreshAdvTalentSkill();
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("TALENT_UPGRADE",__talenChangeHanler);
         NotificationManager.instance.removeEventListener("TALENT_RESET",__talenChangeHanler);
         _washBtn.removeEventListener("click",__washPoint);
         _upGrade.removeEventListener("click",__upGrade);
         NotificationManager.instance.removeEventListener("CHANGETALENTVIEW",changeTalent);
      }
      
      private function refreshData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(thane.talentData.talentGrade + 1,21);
         if(_loc1_)
         {
            _nextLevelNeedCoin = _loc1_.TemplateId;
            _nextLevelExp = _loc1_.Data;
            _levelUpCoinTxt.text = FormularySets.toStringSelf(_nextLevelNeedCoin,9999999);
            _levelUpExpTxt.text = FormularySets.toStringSelf(_nextLevelExp,9999999);
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,212012));
            if(ResourceManager.instance.gold.count < _nextLevelNeedCoin || thane.gp < _nextLevelExp && _loc2_ < 1)
            {
               _upGrade.enable = false;
            }
            else
            {
               _upGrade.enable = true;
            }
            if(ResourceManager.instance.gold.count < _nextLevelNeedCoin)
            {
               _curCoinTxt.setFrame(2);
            }
            else
            {
               _curCoinTxt.setFrame(1);
            }
            if(thane.gp < _nextLevelExp)
            {
               _curExpTxt.setFrame(2);
            }
            else
            {
               _curExpTxt.setFrame(1);
            }
         }
         else
         {
            _levelUpCoinTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _levelUpExpTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _upGrade.enable = false;
         }
         _curCoinTxt.text = FormularySets.toStringSelf(ResourceManager.instance.gold.count,9999999);
         _curExpTxt.text = FormularySets.toStringSelf(thane.gp,9999999);
         _currentHaveStoneTxt.text = GoodsManager.instance.getBagCountByTempId(1,212012).toString();
         _remainPointTxt.text = thane.talentData.talentPoint.toString();
         _washBtn.enable = !StringHelper.isNullOrEmpty(thane.talentData.talentScript);
         NumberViewUtils.refreshValue(thane.talentData.talentGrade,_talentLvMv.container,_numBit,19,25,15,19,"0123456789");
      }
      
      private function initSkillList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TalentItemView = null;
         _skillDic = new Dictionary(true);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = new TalentItemView();
            _loc2_.x = _siteArr[_loc1_][0];
            _loc2_.y = _siteArr[_loc1_][1];
            _container.addChild(_loc2_);
            _skillDic[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      private function initAdvSkillList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TalentItemView = null;
         _advSkillDic = new Dictionary(true);
         _loc1_ = 10;
         while(_loc1_ < 15)
         {
            _loc2_ = new TalentItemView();
            _loc2_.x = _advSiteArr[_loc1_ - 10][0];
            _loc2_.y = _advSiteArr[_loc1_ - 10][1];
            _advancedContainer.addChild(_loc2_);
            _advSkillDic[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      protected function __upGrade(param1:MouseEvent) : void
      {
         if(ResourceManager.instance.gold.count < _nextLevelNeedCoin)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentGradeUpFailed01"));
            return;
         }
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,212012));
         if(thane.gp < _nextLevelExp && _loc2_ < 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentGradeUpFailed02"));
            return;
         }
         ArmyManager.instance.addEventListener("TALENT_GRADUP_SUCC",__talentGradeUpSucc);
         if(TalentTabBtnView.SELECTEDINDEX == 0)
         {
            control.sendUpTalentGrade(false);
         }
         else if(TalentTabBtnView.SELECTEDINDEX == 1)
         {
            if(thane.talentData.talentGrade < 80)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentView.upGradePrompt"));
               return;
            }
            control.sendUpTalentGrade(true);
         }
      }
      
      protected function __talentGradeUpSucc(param1:TalentEvent) : void
      {
         ArmyManager.instance.removeEventListener("TALENT_GRADUP_SUCC",__talentGradeUpSucc);
         if(TalentTabBtnView.SELECTEDINDEX == 0)
         {
            __talenChangeHanler(null);
         }
         else if(TalentTabBtnView.SELECTEDINDEX == 1)
         {
            refreshAdvTalentSkill();
         }
      }
      
      protected function __washPoint(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.talent.content01",100);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         if(KingContractManager.Instance.checkHasBuffById(9))
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.talent.content02");
            SimpleAlertHelper.instance.data = [alertBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
         }
         else
         {
            SimpleAlertHelper.instance.data = [payCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",100);
         }
      }
      
      private function alertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(TalentTabBtnView.SELECTEDINDEX == 0)
            {
               control.sendWashTalentSkillPoint(0,1,true);
            }
            else if(TalentTabBtnView.SELECTEDINDEX == 1)
            {
               control.sendWashTalentSkillPoint(0,2,true);
            }
         }
      }
      
      private function payCallBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 0) : void
      {
         if(param1)
         {
            if(TalentTabBtnView.SELECTEDINDEX == 0)
            {
               control.sendWashTalentSkillPoint(param4,1,param2);
            }
            else if(TalentTabBtnView.SELECTEDINDEX == 1)
            {
               control.sendWashTalentSkillPoint(param4,2,param2);
            }
         }
      }
      
      private function changeTalent(param1:NotificationEvent) : void
      {
         var _loc2_:int = TalentTabBtnView.SELECTEDINDEX;
         switch(_loc2_)
         {
            case 0:
               _back.visible = true;
               _advBack.visible = false;
               _container.visible = true;
               _advancedContainer.visible = false;
               __talenChangeHanler(null);
               break;
            case 1:
               _back.visible = false;
               _advBack.visible = true;
               _container.visible = false;
               _advancedContainer.visible = true;
               refreshAdvTalentSkill();
         }
      }
      
      private function refreshTalentSkill() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SkillInfo = null;
         var _loc4_:TalentItemView = null;
         for(var _loc3_:String in _skillDic)
         {
            _loc2_ = int(_loc3_);
            _loc1_ = thane.talentData.allTalentList[_loc2_] as SkillInfo;
            _loc4_ = _skillDic[_loc3_] as TalentItemView;
            if(_loc1_)
            {
               _loc4_.data = _loc1_;
            }
            else
            {
               _loc4_.data = null;
            }
         }
      }
      
      private function refreshAdvTalentSkill() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SkillInfo = null;
         var _loc4_:TalentItemView = null;
         for(var _loc3_:String in _advSkillDic)
         {
            _loc2_ = int(_loc3_);
            _loc1_ = thane.talentData.allTalentList[_loc2_] as SkillInfo;
            _loc4_ = _advSkillDic[_loc2_ + ""] as TalentItemView;
            if(_loc1_)
            {
               _loc4_.data = _loc1_;
            }
            else
            {
               _loc4_.data = null;
            }
         }
         refreshAdvData();
      }
      
      private function refreshAdvData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(thane.talentData.advTalentGrade + 1,38);
         if(_loc1_)
         {
            _nextLevelNeedCoin = _loc1_.TemplateId;
            _nextLevelExp = _loc1_.Data;
            _levelUpCoinTxt.text = FormularySets.toStringSelf(_nextLevelNeedCoin,9999999);
            _levelUpExpTxt.text = FormularySets.toStringSelf(_nextLevelExp,9999999);
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,212012));
            if(ResourceManager.instance.gold.count < _nextLevelNeedCoin || thane.gp < _nextLevelExp && _loc2_ < 1)
            {
               _upGrade.enable = false;
            }
            else
            {
               _upGrade.enable = true;
            }
            _curCoinTxt.text = FormularySets.toStringSelf(ResourceManager.instance.gold.count,9999999);
            _curExpTxt.text = FormularySets.toStringSelf(thane.gp,9999999);
            if(ResourceManager.instance.gold.count < _nextLevelNeedCoin)
            {
               _curCoinTxt.setFrame(2);
            }
            else
            {
               _curCoinTxt.setFrame(1);
            }
            if(thane.gp < _nextLevelExp)
            {
               _curExpTxt.setFrame(2);
            }
            else
            {
               _curExpTxt.setFrame(1);
            }
         }
         else
         {
            _levelUpCoinTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _levelUpExpTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _upGrade.enable = false;
         }
         _remainPointTxt.text = thane.talentData.advTalentPoint.toString();
         _currentHaveStoneTxt.text = GoodsManager.instance.getBagCountByTempId(1,212012).toString();
         _washBtn.enable = !StringHelper.isNullOrEmpty(thane.talentData.advTalentScript);
         NumberViewUtils.refreshValue(thane.talentData.advTalentGrade,_talentLvMv.container,_numBit,19,25,15,19,"0123456789");
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_container);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

