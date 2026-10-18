package magicCard.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import manager.LanguageMgr;
   import mvc.module.card.MagicCardInfo;
   import yishi.manager.MagicCardManager;
   import yishi.view.community.BaseIconView;
   
   public class MagicCardSlotOrgItem extends MagicCardSlotItem
   {
      
      public function MagicCardSlotOrgItem()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotOrgItem.ItemBg");
         _shineBg = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotOrgItem.shineBg");
         _cell = ComponentFactory.Instance.creatCustomObject("magicCard.magicCardOrgCell");
         _levelupBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotOrgItem.levelupBtn");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotOrgItem.checkBtn");
         _shareBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotOrgItem.shareBtn");
         _centerEffect = ComponentFactory.Instance.creatCustomObject("magicCard.centerCardEffect");
         addChild(_bg);
         addChild(_shineBg);
         addChild(_cell);
         addChild(_centerEffect);
         addChild(_levelupBtn);
         addChild(_checkBtn);
         addChild(_shareBtn);
         _bg.setFrame(2);
         _shineBg.visible = false;
         _levelupBtn.visible = false;
         _checkBtn.visible = false;
         _shareBtn.visible = false;
         _centerEffect.visible = false;
         _centerEffect.gotoAndStop(_centerEffect.totalFrames);
         _levelupBtn.tipData = LanguageMgr.GetTranslation("card.CardFrame.levelup");
         _checkBtn.tipData = LanguageMgr.GetTranslation("card.CardFrame.check");
         _shareBtn.tipData = LanguageMgr.GetTranslation("card.CardFrame.share");
      }
      
      override public function setTypeAndPos(param1:int, param2:int, param3:int) : void
      {
         super.setTypeAndPos(param1,param2,param3);
         _cell.visible = true;
         if(super._activeBtn != null)
         {
            super._activeBtn.visible = true;
         }
         if(super._canActiveBg != null)
         {
            super._canActiveBg.visible = true;
         }
         this.tipData = null;
         if(_cardTempInfo == null)
         {
            _cell.visible = false;
            this.tipData = LanguageMgr.GetTranslation("armyII.viewII.rune.FastRuneItem.OpenTipTxt1");
            if(super._activeBtn != null)
            {
               super._activeBtn.visible = false;
            }
            if(super._canActiveBg != null)
            {
               super._canActiveBg.visible = false;
            }
         }
         _cell.setScale = 0.43;
         _cell.setLevelupScale = 0.9;
         BaseIconView(_cell.icon).scaleX = 1.2;
         BaseIconView(_cell.icon).scaleY = 1.25;
         if(super._canActiveBg != null)
         {
            super._canActiveBg.scaleX = 1.3;
         }
         if(super._canActiveBg != null)
         {
            super._canActiveBg.scaleY = 1.28;
         }
         if(super._activeBtn != null)
         {
            super._activeBtn.x = 33;
         }
         if(super._activeBtn != null)
         {
            super._activeBtn.y = 208;
         }
         isPlayEffect(param1,param2);
      }
      
      override public function isPlayEffect(param1:int, param2:int) : void
      {
         var _loc3_:MagicCardInfo = MagicCardManager.Instance.cardModel.getInfoByTypeAndPos(param1,param2);
         if(_loc3_ == null)
         {
            return;
         }
         _centerEffect.visible = true;
         if(_loc3_.isActive)
         {
            _centerEffect.gotoAndPlay(1);
            _loc3_.isActive = false;
         }
         else
         {
            _centerEffect.gotoAndStop(_centerEffect.totalFrames);
            _centerEffect["mcLight"].gotoAndStop(1);
         }
      }
      
      public function set tipData(param1:String) : void
      {
         _bg.tipData = param1;
      }
   }
}

