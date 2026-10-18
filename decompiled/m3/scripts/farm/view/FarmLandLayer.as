package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.data.FarmLandInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.utils.SimpleDictionary;
   
   public class FarmLandLayer extends Sprite implements Disposeable
   {
      
      private var _itemDic:SimpleDictionary;
      
      private var _unopenImg:Bitmap;
      
      private var _switchTimeOut:uint;
      
      private var _data:FarmInfo;
      
      public function FarmLandLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:FarmLandItem = null;
         _itemDic = new SimpleDictionary();
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("farm.FarmLandItem");
            _loc1_.pos = _loc2_;
            _loc1_.isOpen = false;
            _loc1_.x = int(_loc2_ / 3) * 70 - _loc2_ % 3 * 60;
            _loc1_.y = _loc2_ % 3 * 35 + int(_loc2_ / 3) * 35;
            _itemDic.add(_loc1_.pos,_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
         _unopenImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemUnopenImg");
      }
      
      public function getLandItem(param1:int) : FarmLandItem
      {
         return _itemDic[param1];
      }
      
      private function addEvent() : void
      {
         model.addEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function __selectedFarmChangeHandler(param1:FarmEvent) : void
      {
         clearTimeout(_switchTimeOut);
         itemSomeVisible = false;
         _switchTimeOut = setTimeout(showCall,200);
         data = param1.data as FarmInfo;
      }
      
      private function showCall() : void
      {
         clearTimeout(_switchTimeOut);
         itemSomeVisible = true;
      }
      
      private function set itemSomeVisible(param1:Boolean) : void
      {
         for each(var _loc2_:FarmLandItem in _itemDic)
         {
            _loc2_.someVisible = param1;
         }
      }
      
      private function addFarmListener(param1:FarmInfo) : void
      {
         if(param1)
         {
            param1.addEventListener("LAND_OPEN",__landOpenHandler);
         }
      }
      
      private function removeFarmListener(param1:FarmInfo) : void
      {
         if(param1)
         {
            param1.removeEventListener("LAND_OPEN",__landOpenHandler);
         }
      }
      
      private function __landOpenHandler(param1:FarmEvent) : void
      {
         addLandInfoToItem(param1.data as FarmLandInfo);
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            for each(var _loc1_:FarmLandInfo in _data.getLandList())
            {
               addLandInfoToItem(_loc1_);
            }
         }
      }
      
      private function addLandInfoToItem(param1:FarmLandInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:FarmLandItem = _itemDic[param1.pos];
         if(_loc3_)
         {
            _loc3_.data = param1;
            _loc3_.tipData = null;
            _loc3_.isOpen = true;
            if(_unopenImg && _unopenImg.parent)
            {
               _unopenImg.parent.removeChild(_unopenImg);
            }
         }
         var _loc2_:int = param1.pos + 1;
         var _loc4_:FarmLandItem = _itemDic[_loc2_];
         if(_loc2_ >= 3 && _loc4_ && !_loc4_.isOpen)
         {
            _loc4_.tipData = LanguageMgr.GetTranslation("farm.view.FarmLandLayer.needFarmGradeTip",(_loc2_ - 2) * 5);
            _loc4_.addChild(_unopenImg);
         }
      }
      
      private function clean() : void
      {
         for each(var _loc1_:FarmLandItem in _itemDic)
         {
            _loc1_.data = null;
            _loc1_.tipData = null;
            _loc1_.isOpen = false;
         }
         if(_unopenImg && _unopenImg.parent)
         {
            _unopenImg.parent.removeChild(_unopenImg);
         }
      }
      
      public function set data(param1:FarmInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         clean();
         FarmManager.instance.closeBagFrame();
         removeFarmListener(_data);
         _data = param1;
         addFarmListener(_data);
         refreshView();
      }
      
      public function get data() : FarmInfo
      {
         return _data;
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      public function dispose() : void
      {
         clearTimeout(_switchTimeOut);
         removeFarmListener(_data);
         removeEvent();
         if(_itemDic)
         {
            _itemDic.clear();
         }
         _itemDic = null;
         ObjectUtils.disposeObject(_unopenImg);
         _unopenImg = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

