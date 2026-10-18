package abysm.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mainBar.StripView;
   import mvc.module.outyard.AbysmBossInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class AbysmBossHeadItemView extends Sprite implements Disposeable
   {
      
      private var _choseItemEffect:MovieClip;
      
      private var _childIcon:BaseIconView;
      
      private var _pos:int;
      
      private var _bossStrip:StripView;
      
      public function AbysmBossHeadItemView(param1:int)
      {
         _pos = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _choseItemEffect = ComponentFactory.Instance.creatCustomObject("abysm.choseItemEffect");
         _childIcon = ComponentFactory.Instance.creatCustomObject("abysm.bossIcon");
         _bossStrip = ComponentFactory.Instance.creatCustomObject("abysm.bossIconStrip");
         _bossStrip.setHitArea(0,0,50,50);
         _bossStrip.buttonMode = true;
         addChild(_choseItemEffect);
         addChild(_childIcon);
         addChild(_bossStrip);
      }
      
      public function set info(param1:AbysmBossInfo) : void
      {
         _choseItemEffect.visible = false;
         if(param1.state == 1)
         {
            _choseItemEffect.visible = true;
         }
         var _loc2_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1.bossId);
         _childIcon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
         _bossStrip.tipData = "" + _loc2_.TemplateName;
      }
      
      override public function get width() : Number
      {
         return 55;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_choseItemEffect);
         _choseItemEffect = null;
         ObjectUtils.disposeObject(_childIcon);
         _childIcon = null;
         ObjectUtils.disposeObject(_bossStrip);
         _bossStrip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

