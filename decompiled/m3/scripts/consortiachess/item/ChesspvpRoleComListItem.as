package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   
   public class ChesspvpRoleComListItem extends Sprite
   {
      
      protected var _rollBit:ScaleBitmapImage;
      
      protected var _inRoleNumTx:FilterFrameText;
      
      protected var _role1:Bitmap;
      
      private var _type:int;
      
      public function ChesspvpRoleComListItem(param1:int)
      {
         super();
         _type = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         this.graphics.beginFill(16711680,0);
         this.graphics.drawRect(0,0,90,30);
         this.graphics.endFill();
         _rollBit = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.in.comboxItembgB");
         _inRoleNumTx = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRoleComTx");
         _role1 = new Bitmap();
         addChild(_rollBit);
         addChild(_role1);
         addChild(_inRoleNumTx);
         _rollBit.x = -10;
         _rollBit.visible = false;
         if(_type > 0)
         {
            _role1.bitmapData = ChesspvpResourceUtil.ins.roleDataList[_type];
            _inRoleNumTx.text = LanguageMgr.GetTranslation("chesspvp.role.type" + _type);
         }
         else
         {
            _role1.bitmapData = null;
            _inRoleNumTx.text = "--";
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("rollOut",outHandler);
         this.addEventListener("rollOver",overHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("rollOut",outHandler);
         this.removeEventListener("rollOver",overHandler);
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _rollBit.visible = false;
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         _rollBit.visible = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_inRoleNumTx);
         _inRoleNumTx = null;
         ObjectUtils.disposeObject(_rollBit);
         _rollBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

