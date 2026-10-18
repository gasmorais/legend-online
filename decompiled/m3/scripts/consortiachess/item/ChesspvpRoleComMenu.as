package consortiachess.item
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpOp;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ChesspvpRoleComMenu extends Sprite
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemList:Array = [];
      
      private var _data:ThaneInfo;
      
      private var _isDie:Boolean = false;
      
      public function ChesspvpRoleComMenu()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:ChesspvpRoleComListItem = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         addChild(_bg);
         _bg.width = 104;
         _bg.height = 220;
         _loc2_ = 0;
         while(_loc2_ <= 6)
         {
            _loc1_ = new ChesspvpRoleComListItem(_loc2_);
            _loc1_.x = 12;
            _loc1_.y = 31 * _loc2_;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function setData(param1:ThaneInfo) : void
      {
         _data = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("click",__stageMouseDown);
         for each(var _loc1_:ChesspvpRoleComListItem in _itemList)
         {
            _loc1_.addEventListener("click",itemClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("click",__stageMouseDown);
         for each(var _loc1_:ChesspvpRoleComListItem in _itemList)
         {
            _loc1_.removeEventListener("click",itemClickHandler);
         }
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ChesspvpRoleComListItem = param1.currentTarget as ChesspvpRoleComListItem;
         ChessPvpManager.Instance.operFun(ChessPvpOp.OP_EDIT,_data.userId,_loc2_.type);
         dispose();
      }
      
      protected function __stageMouseDown(param1:MouseEvent) : void
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
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

