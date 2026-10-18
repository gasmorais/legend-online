package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import map.campaign.data.CampaignArmy;
   import yishi.filter.UIFilter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class HeroItem extends Component
   {
      
      private var _icon:BaseIconView;
      
      private var _hp:MovieClip;
      
      private var _hpBlack:Image;
      
      public var _userId:int;
      
      private var _filters:UIFilter;
      
      private var _heroArmy:CampaignArmy;
      
      public function HeroItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("dungeoturn.HeroItem.icon");
         _hp = ComponentFactory.Instance.creatCustomObject("dungeourn.heroItem.hp");
         _hpBlack = ComponentFactory.Instance.creatComponentByStylename("dungeourn.heroItem.hpBlack");
         addChild(_icon);
         addChild(_hpBlack);
         addChild(_hp);
         _filters = new UIFilter();
         _icon.icon = IconFactory.getHeroicon(6);
         tipStyle = "yishi.view.tips.OneLineTip";
         isFollowMouse = false;
         tipDirctions = "0";
         tipGapV = 0;
         tipGapH = 0;
      }
      
      private function addEvent() : void
      {
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         _heroArmy = param1;
         _icon.icon = IconFactory.getHeadIcon(param1.baseHero.headId,"head");
         _userId = param1.baseHero.userId;
         _hp.gotoAndStop(100);
      }
      
      public function set hp(param1:int) : void
      {
         _hp.gotoAndStop(param1);
         tipData = _heroArmy.baseHero.nickName + "\n" + LanguageMgr.GetTranslation("dungeoturn.HeroItem.icon.tipdata",param1);
         if(param1 == 0)
         {
            _filters.setGrayFilter(_hp);
            _hp.visible = false;
            _filters.setGrayFilter(_icon);
         }
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_hp);
         _hp = null;
         ObjectUtils.disposeObject(_hpBlack);
         _hpBlack = null;
         _filters = null;
         super.dispose();
      }
   }
}

