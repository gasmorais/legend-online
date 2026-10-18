package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.PetEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class RemotePetTurnSingleItemView extends Component
   {
      
      private var _icon:BaseIconView;
      
      private var _progressBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _mask:Sprite;
      
      private var _data:PetData;
      
      private var _index:int;
      
      private var _filter:IFilterFormat;
      
      public function RemotePetTurnSingleItemView(param1:int)
      {
         _index = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetTurnSingleItemView.icon");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetTurnSingleItemView.progressBg");
         _progress = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetTurnSingleItemView.progress");
         _mask = new Sprite();
         _mask.x = _progress.x;
         _mask.y = _progress.y;
         addChild(_icon);
         addChild(_progressBg);
         addChild(_progress);
         addChild(_mask);
         _progress.mask = _mask;
         _filter = new UIFilter();
      }
      
      public function set data(param1:PetData) : void
      {
         if(param1)
         {
            _data = param1;
            fresh(_data);
         }
      }
      
      private function fresh(param1:PetData = null) : void
      {
         var _loc2_:Number = NaN;
         if(param1)
         {
            _icon.icon = IconFactory.getPetHeadItemIcon(param1.templateId);
            _icon.tipData = param1;
            _loc2_ = param1.remoteHp / 100;
            if(_loc2_ == 0)
            {
               _filter.setGrayFilter(_icon);
            }
            creatMask(_loc2_);
         }
      }
      
      private function creatMask(param1:Number) : void
      {
         if(param1 >= 1)
         {
            param1 = 1;
         }
         if(_mask)
         {
            _mask.graphics.clear();
            _mask.graphics.beginFill(0,0);
            _mask.graphics.drawRect(0,0,param1 * 53,7);
            _mask.graphics.endFill();
         }
      }
      
      private function __petUpdateHandler(param1:PetEvent) : void
      {
         var _loc2_:PetData = param1.data as PetData;
         if(!_loc2_)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         if(_data.petId == _loc2_.petId)
         {
            fresh(_loc2_);
         }
      }
      
      private function addEvent() : void
      {
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("PET_UPDATE",__petUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("PET_UPDATE",__petUpdateHandler);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _data = null;
         super.dispose();
      }
   }
}

