package theseus.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   
   public class TheseusWarHufaChooseView extends Sprite
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _materialViewList:SimpleTileList;
      
      private var _materialScroll:ScrollPanel;
      
      private var _materialData:Array;
      
      private var _materialList:Vector.<BaseItemView>;
      
      private var _column:int = 4;
      
      public function TheseusWarHufaChooseView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warChooseFHMcc");
         _materialViewList = ComponentFactory.Instance.creatCustomObject("theseus.BagII.materialViewList",[_column]);
         _materialScroll = ComponentFactory.Instance.creatComponentByStylename("theseus.fuhuaChoose.materialScroll");
         _materialScroll.setView(_materialViewList);
         _materialList = new Vector.<BaseItemView>();
         addChild(_bg);
         addChild(_materialScroll);
      }
      
      public function refreshView(param1:Array) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc5_:* = 0;
         param1.sort(sortP7);
         var _loc6_:int = int(param1.length);
         var _loc7_:int = int(_materialList.length);
         var _loc4_:int = Math.max(_loc6_,_loc7_);
         var _loc3_:int = Math.ceil(_loc4_ / _column) * _column;
         _materialViewList.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc5_ >= _loc7_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("theseus.fuhuaChoose.BagCell");
               _loc2_.addEventListener("click",itemClickHandler);
               _materialViewList.addChild(_loc2_);
               _materialList.push(_loc2_);
            }
            else
            {
               _loc2_ = _materialList[_loc5_];
            }
            if(_loc5_ >= _loc6_)
            {
               _loc2_.data = null;
            }
            else
            {
               _loc2_.data = param1[_loc5_];
            }
            _loc5_++;
         }
         _materialViewList.hSpace = 3;
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
         visible = true;
      }
      
      private function sortP7(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(param1.templateInfo.Property7 > param2.templateInfo.Property7)
         {
            return 1;
         }
         if(param1.templateInfo.Property7 > param2.templateInfo.Property7)
         {
            return 0;
         }
         return -1;
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseItemView = param1.currentTarget as BaseItemView;
         var _loc3_:GoodsInfo = _loc2_.data;
         if(_loc3_)
         {
            visible = false;
            PlayerManager.instance.moveBagToBag(_loc3_.bagType,_loc3_.objectId,_loc3_.pos,0,0,0,1);
         }
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:BaseItemView in _materialList)
         {
            _loc1_.removeEventListener("click",itemClickHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:BaseItemView in _materialList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _materialList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_materialViewList);
         _materialViewList = null;
         ObjectUtils.disposeObject(_materialScroll);
         _materialScroll = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

