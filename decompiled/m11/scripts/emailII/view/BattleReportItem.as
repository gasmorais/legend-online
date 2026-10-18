package emailII.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.emailII.BattleInfo;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.view.community.HeroCell;
   
   public class BattleReportItem extends Sprite implements Disposeable
   {
      
      private var _cell:HeroCell;
      
      private var _winIcon:Bitmap;
      
      private var _nameBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _goldTxt:FilterFrameText;
      
      private var _fightValueTxt:FilterFrameText;
      
      private var _goldValueTxt:FilterFrameText;
      
      private var _crystalIcon:DisplayObject;
      
      private var _victoryWords:DisplayObject;
      
      private var _crystalValueTxt:FilterFrameText;
      
      private var _pawn1Text:FilterFrameText;
      
      private var _pawn1ValueText:FilterFrameText;
      
      private var _pawn2Text:FilterFrameText;
      
      private var _pawn2ValueText:FilterFrameText;
      
      private var _isSelf:Boolean;
      
      private var _data:BattleInfo;
      
      public function BattleReportItem(param1:Boolean = false)
      {
         super();
         _isSelf = param1;
         initView();
      }
      
      private function initView() : void
      {
         _cell = ComponentFactory.Instance.creatCustomObject("email.HeroCell");
         _winIcon = ComponentFactory.Instance.creatBitmap("asset.email.ReportSuccessIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportNicknameTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportLevelTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportFightTxt");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportGoldTxt");
         _crystalIcon = ComponentFactory.Instance.creatBitmap("asset.email.CrystalIcon");
         _victoryWords = ComponentFactory.Instance.creatBitmap("asset.email.RewardWords");
         _crystalValueTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportCrystalValueTxt");
         _fightValueTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportFightValueTxt");
         _goldValueTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportGoldValueTxt");
         _pawn1Text = ComponentFactory.Instance.creatComponentByStylename("email.ReportPawn1Txt");
         _pawn1ValueText = ComponentFactory.Instance.creatComponentByStylename("email.ReportPawn1ValueTxt");
         _pawn2Text = ComponentFactory.Instance.creatComponentByStylename("email.ReportPawn2Txt");
         _pawn2ValueText = ComponentFactory.Instance.creatComponentByStylename("email.ReportPawn2ValueTxt");
         if(_isSelf)
         {
            _nameBg = ComponentFactory.Instance.creatBitmap("asset.email.BattleReportSelfBg");
         }
         else
         {
            _nameBg = ComponentFactory.Instance.creatBitmap("asset.email.BattleReportEnemyBg");
         }
         _cell.type = "head";
         addChild(_cell);
         addChild(_nameBg);
         addChild(_winIcon);
         addChild(_nameTxt);
         addChild(_levelTxt);
         addChild(_fightTxt);
         addChild(_fightValueTxt);
         addChild(_goldTxt);
         addChild(_goldValueTxt);
         addChild(_crystalIcon);
         addChild(_victoryWords);
         addChild(_crystalValueTxt);
         _crystalIcon.visible = false;
         _victoryWords.visible = false;
         _crystalValueTxt.visible = false;
         addChild(_pawn1Text);
         addChild(_pawn1ValueText);
         addChild(_pawn2Text);
         addChild(_pawn2ValueText);
         _pawn1ValueText.setFrame(2);
         _pawn2ValueText.setFrame(2);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get data() : BattleInfo
      {
         return _data;
      }
      
      public function set data(param1:BattleInfo) : void
      {
         clean();
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(_isSelf)
         {
            setSelf();
         }
         else
         {
            setEnemy();
         }
      }
      
      private function clean() : void
      {
         _cell.data = null;
         _pawn1Text.text = "";
         _pawn1ValueText.text = "";
         _pawn2Text.text = "";
         _pawn2ValueText.text = "";
      }
      
      private function setEnemy() : void
      {
         var _loc1_:ThaneInfo = null;
         if(_data.enemyHeroId != 0)
         {
            _loc1_ = new ThaneInfo();
            _loc1_.templateId = _data.enemyHeroId;
            _cell.data = _loc1_;
         }
         _nameTxt.text = _data.playerName;
         _levelTxt.x = _nameTxt.x + _nameTxt.textWidth + 10;
         _levelTxt.text = LanguageMgr.GetTranslation("public.level2",_data.enemyGrade);
         _winIcon.visible = _data.result != 1;
         _fightTxt.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _goldTxt.text = LanguageMgr.GetTranslation("emailII.view.BattleReportItem.gold");
         _fightValueTxt.text = _data.enemyFight;
         if(_data.enemyGold >= 0)
         {
            _goldValueTxt.setFrame(1);
            _goldValueTxt.text = "+" + _data.enemyGold;
         }
         else
         {
            _goldValueTxt.setFrame(2);
            _goldValueTxt.text = _data.enemyGold.toString();
         }
         if(_data.enemyCrystal <= 0)
         {
            _crystalIcon.visible = false;
            _victoryWords.visible = false;
            _crystalValueTxt.visible = false;
         }
         if(_data.enemySite1Count > 0)
         {
            _pawn1Text.text = _data.enemySite1Name;
            _pawn1ValueText.text = "-" + _data.enemySite1Count;
            if(_data.enemySite2Count > 0)
            {
               _pawn2Text.text = _data.enemySite2Name;
               _pawn2ValueText.text = "-" + _data.enemySite2Count;
            }
         }
         else if(_data.enemySite2Count > 0)
         {
            _pawn1Text.text = _data.enemySite2Name;
            _pawn1ValueText.text = "-" + _data.enemySite2Count;
         }
      }
      
      private function setSelf() : void
      {
         var _loc1_:String = null;
         var _loc2_:MagicSpringSlotInfo = null;
         var _loc3_:int = 0;
         _cell.data = ArmyManager.instance.thane;
         _nameTxt.text = ArmyManager.instance.thane.nickName;
         _levelTxt.x = _nameTxt.x + _nameTxt.textWidth + 10;
         _levelTxt.text = LanguageMgr.GetTranslation("public.level2",_data.selfGrade);
         _winIcon.visible = _data.result == 1;
         _fightTxt.text = LanguageMgr.GetTranslation("emailII.view.BattleReportItem.fightTxtText");
         _goldTxt.text = LanguageMgr.GetTranslation("emailII.view.BattleReportItem.goldTxtText");
         _fightValueTxt.text = _data.selfFight;
         if(_data.selfGold > 0)
         {
            _goldValueTxt.setFrame(1);
            _loc1_ = "";
            _loc2_ = MagicSpringManager.instance.model.checkIsExistBuffer(1);
            if(_loc2_)
            {
               _loc3_ = Math.floor(_loc2_.tempInfo.AddValue * _data.selfGold / 100);
               _loc1_ = LanguageMgr.GetTranslation("MagicSpringFrame.buffer.addText",_loc3_);
            }
            _goldValueTxt.htmlText = "+" + _data.selfGold + _loc1_;
         }
         else
         {
            _goldValueTxt.setFrame(2);
            _goldValueTxt.text = _data.selfGold.toString();
         }
         if(_data.selfCrystal > 0)
         {
            _crystalIcon.visible = true;
            _victoryWords.visible = true;
            _crystalValueTxt.visible = true;
            _crystalValueTxt.text = _data.selfCrystal + "";
         }
         else
         {
            _crystalIcon.visible = false;
            _victoryWords.visible = false;
            _crystalValueTxt.visible = false;
         }
         if(_data.selfSite1Count > 0)
         {
            _pawn1Text.text = _data.selfSite1Name;
            _pawn1ValueText.text = "-" + _data.selfSite1Count;
            if(_data.selfSite2Count > 0)
            {
               _pawn2Text.text = _data.selfSite2Name;
               _pawn2ValueText.text = "-" + _data.selfSite2Count;
            }
         }
         else if(_data.selfSite2Count > 0)
         {
            _pawn1Text.text = _data.selfSite2Name;
            _pawn1ValueText.text = "-" + _data.selfSite2Count;
         }
      }
   }
}

