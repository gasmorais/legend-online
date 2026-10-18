package buildings.transferbuilding.view.planesbag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.community.BaseItemView;
   
   public class PlanesGoodsItemMenu extends Sprite implements Disposeable
   {
      
      private var _useBtn:TextButton;
      
      private var _currentCell:BaseItemView;
      
      public function PlanesGoodsItemMenu(param1:BaseItemView)
      {
         super();
         _currentCell = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _useBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
         _useBtn.text = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.use");
         addChild(_useBtn);
      }
      
      private function initEvent() : void
      {
         _useBtn.addEventListener("click",__userHandler);
      }
      
      private function removeEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.removeEventListener("click",__userHandler);
         }
      }
      
      private function __userHandler(param1:MouseEvent) : void
      {
         if(_currentCell.data.templateInfo.SonType != 606)
         {
            return;
         }
         SocketSendManager.instance.sendUseItem(_currentCell.data.pos);
         dispose();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _currentCell = null;
         if(_useBtn)
         {
            ObjectUtils.disposeObject(_useBtn);
         }
         _useBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

