package eclipticpalace.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.EclipticPalaceManager;
   import mvc.module.eclipticpalace.EclipticPalaceBossInfo;
   import mvc.module.eclipticpalace.EclipticPalaceModel;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class EclipticPalaceBossItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _fightImage:Bitmap;
      
      private var _eventImage:Bitmap;
      
      private var _bossItem:BaseIconView;
      
      private var _stateImage:Bitmap;
      
      private var _data:EclipticPalaceBossInfo;
      
      private var _index:int;
      
      private var _parentIndex:int;
      
      public function EclipticPalaceBossItem(param1:int, param2:int)
      {
         super();
         _index = param1;
         _parentIndex = param2;
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceBossItem.back");
         _bossItem = ComponentFactory.Instance.creatCustomObject("EclipticPalaceBossItem.bossItem");
         _fightImage = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceBossItem.fightImage");
         _eventImage = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceBossItem.eventImage");
         _stateImage = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceBossItem.stateImage");
         addChild(_bossItem);
         addChild(_back);
         addChild(_eventImage);
         addChild(_stateImage);
         addChild(_fightImage);
         _eventImage.visible = false;
         _fightImage.visible = false;
         _stateImage.visible = false;
      }
      
      public function get data() : EclipticPalaceBossInfo
      {
         return _data;
      }
      
      public function set data(param1:EclipticPalaceBossInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:int = int(model.selectedRoute != 0 ? model.selectedRoute : int(model.selectPath));
         _fightImage.visible = _parentIndex == _loc2_ && _index == model.fightIndex;
         _eventImage.visible = data.hiddenEvent;
         _stateImage.visible = data.defeated;
         _bossItem.icon = IconFactory.getHeroicon(data.heroTempId);
      }
      
      private function get model() : EclipticPalaceModel
      {
         return EclipticPalaceManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_eventImage);
         _eventImage = null;
         ObjectUtils.disposeObject(_stateImage);
         _stateImage = null;
         ObjectUtils.disposeObject(_fightImage);
         _fightImage = null;
         ObjectUtils.disposeObject(_bossItem);
         _bossItem = null;
         super.dispose();
      }
   }
}

