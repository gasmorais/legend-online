package battle.view.ui
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class HeroRoleHeadView extends Sprite implements Disposeable
   {
      
      private var _info:HeroRoleInfo;
      
      private var _parent:DisplayObjectContainer;
      
      private var _head:BaseIconView;
      
      private var _containerRect:Rectangle;
      
      private var _headScale:Number;
      
      public function HeroRoleHeadView(param1:DisplayObjectContainer, param2:Rectangle = null, param3:Number = 1)
      {
         super();
         _parent = param1;
         _containerRect = param2;
         _headScale = param3;
         _head = new BaseIconView(iconLoaded);
         addChild(_head);
         _parent.addChild(this);
      }
      
      public function set info(param1:HeroRoleInfo) : void
      {
         if(param1.playerIconId == 0)
         {
            _head.icon = IconFactory.getHeroIconByPics(param1.heroInfo.templateInfo.Icon);
         }
         else
         {
            _head.icon = IconFactory.getPlayerIcon(param1.templateId,"head");
         }
         _info = param1;
      }
      
      public function setPlayerIcon(param1:int) : void
      {
         _head.icon = IconFactory.getPlayerIcon(1,"head");
      }
      
      private function iconLoaded(param1:BaseIconView = null) : void
      {
         if(_containerRect)
         {
            DisplayUtils.fullInRect(_head.content,_containerRect,true);
         }
         if(_headScale == -1)
         {
            _head.content.scaleX = -1 * _head.content.scaleX;
            _head.content.x += _head.content.width;
         }
      }
      
      public function dispose() : void
      {
         if(_head)
         {
            ObjectUtils.disposeObject(_head);
         }
         _head = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

