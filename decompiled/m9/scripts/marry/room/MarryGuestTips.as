package marry.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.marry.MarryGuestInfo;
   import mvc.module.marry.MarrySender;
   import yishi.view.base.ConsortiaSelectedButton;
   
   public class MarryGuestTips extends Sprite implements Disposeable
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _kickOutBtn:ConsortiaSelectedButton;
      
      private var _info:MarryGuestInfo;
      
      public function MarryGuestTips(param1:MarryGuestInfo)
      {
         super();
         _info = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MarryGuestTips.back");
         _kickOutBtn = ComponentFactory.Instance.creatComponentByStylename("MarryGuestTips.kickOutBtn");
         _kickOutBtn.text = LanguageMgr.GetTranslation("marry.room.MarryGuestTips.kickOutText");
         addChild(_back);
         addChild(_kickOutBtn);
      }
      
      private function initEvent() : void
      {
         _kickOutBtn.addEventListener("click",__kickHandler);
         StageReferance.stage.addEventListener("click",__stageMouseDown);
      }
      
      private function removeEvent() : void
      {
         if(_kickOutBtn)
         {
            _kickOutBtn.removeEventListener("click",__kickHandler);
         }
         StageReferance.stage.removeEventListener("click",__stageMouseDown);
      }
      
      private function __kickHandler(param1:MouseEvent) : void
      {
         if(_info)
         {
            MarrySender.kickOutGuest(_info.userIdA);
         }
         dispose();
      }
      
      private function __stageMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(parent)
         {
            _loc2_ = parent.localToGlobal(new Point(this.x,this.y));
            if(isNaN(param1.stageX) || isNaN(param1.stageY) || param1.stageX < _loc2_.x || param1.stageX > _loc2_.x + width || param1.stageY < _loc2_.y || param1.stageY > _loc2_.y + height)
            {
               dispose();
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_kickOutBtn)
         {
            _kickOutBtn.dispose();
         }
         _kickOutBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

