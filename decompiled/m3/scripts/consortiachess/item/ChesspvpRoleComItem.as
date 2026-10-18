package consortiachess.item
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ChesspvpRoleComItem extends Sprite
   {
      
      private var _txt:FilterFrameText;
      
      private var _bit:Bitmap;
      
      private var _btn:BaseButton;
      
      private var _data:ThaneInfo;
      
      private var _menu:ChesspvpRoleComMenu;
      
      private var _canEdit:Boolean;
      
      public function ChesspvpRoleComItem(param1:Boolean)
      {
         super();
         _canEdit = param1;
         initView();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRoleNoTx");
         _bit = new Bitmap();
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.downBtn");
         addChild(_txt);
         addChild(_bit);
         addChild(_btn);
         _txt.text = "--";
         _btn.visible = _canEdit;
         if(_canEdit)
         {
            initEvent();
         }
      }
      
      public function updateRole(param1:int) : void
      {
         if(param1 == 0)
         {
            _txt.text = "--";
            _bit.bitmapData = null;
         }
         else
         {
            _txt.text = "";
            _bit.bitmapData = ChesspvpResourceUtil.ins.roleDataList[param1];
         }
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _btn.enable = true;
         }
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         _menu = new ChesspvpRoleComMenu();
         _menu.setData(_data);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY;
         _menu.show();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

