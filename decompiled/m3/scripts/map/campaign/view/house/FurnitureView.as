package map.campaign.view.house
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import events.FriendUpdateEvent;
   import farm.FarmManager;
   import farm.data.FriendFarmStateInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import home.HomeSender;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import mvc.module.home.FurnitureInfo;
   import mvc.module.home.HomeModel;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.FriendManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   
   public class FurnitureView extends Sprite implements Disposeable
   {
      
      private var _path:String;
      
      private var _data:FurnitureInfo;
      
      private var _view:MovieClip;
      
      private var _filter:SimpleBuildingFilter;
      
      private var _starMc:MovieClip;
      
      private var _hitBitmap:Bitmap;
      
      private var _starContainer:Sprite;
      
      private var _selected:Boolean;
      
      public function FurnitureView()
      {
         super();
         _filter = new SimpleBuildingFilter();
      }
      
      private function setStar() : void
      {
         if(_data == null)
         {
            return;
         }
         if(hasEvent)
         {
            if(_starMc == null)
            {
               _starMc = ComponentFactory.Instance.creat("asset.home.star");
            }
            if(_hitBitmap)
            {
               _starMc.x = _hitBitmap.x + (_hitBitmap.width - _starMc.width) * 0.5;
               _starMc.y = _hitBitmap.y + (_hitBitmap.height - _starMc.height) * 0.5;
            }
            _starContainer.addChild(_starMc);
            _view.buttonMode = true;
         }
         else
         {
            ObjectUtils.disposeViolentMc(_starMc);
            _starMc = null;
         }
      }
      
      private function setHitAreaAndMask() : void
      {
         var _loc1_:Rectangle = _view.getBounds(_view);
         var _loc4_:BitmapData = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         var _loc2_:Matrix = new Matrix();
         _loc2_.translate(-_loc1_.x,-_loc1_.y);
         _loc4_.draw(_view,_loc2_);
         _hitBitmap = new Bitmap(_loc4_);
         _hitBitmap.x = _loc1_.x;
         _hitBitmap.y = _loc1_.y;
         _hitBitmap.visible = false;
         addChild(_hitBitmap);
         var _loc3_:Sprite = DisplayUtils.getHitArea(_loc4_,5);
         _loc3_.x = _loc1_.x;
         _loc3_.y = _loc1_.y;
         _starContainer.addChild(_loc3_);
         _starContainer.mask = _loc3_;
      }
      
      private function get hasEvent() : Boolean
      {
         return _data && _data.furnitureId == model.info.furnitureId && _data.templateInfo.Type != 2 && _data.templateInfo.Type != 1 && inHouse;
      }
      
      public function get data() : FurnitureInfo
      {
         return _data;
      }
      
      public function set data(param1:FurnitureInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _path = "";
         _data = param1;
         if(temp == null)
         {
            return;
         }
         if(_data.rotation > 3 || _data.rotation < 1)
         {
            return;
         }
         var _loc2_:String = temp["Icon" + _data.rotation];
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            return;
         }
         var _loc3_:Array = _loc2_.split(",");
         if(_loc3_.length != 3)
         {
            return;
         }
         _path = PathManager.getFurniturePath(_loc3_[0]);
         if(StringHelper.isNullOrEmpty(_path))
         {
            clean();
            return;
         }
         LoaderManagerII.instance.load(_path,2,8,__iconLoadComplete,null,null,_path);
      }
      
      protected function __iconLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(_path != param1.args || _data == null)
         {
            return;
         }
         clean();
         if(param2 is MovieClip)
         {
            _view = param2 as MovieClip;
            addChild(_view);
            _starContainer = new Sprite();
            addChild(_starContainer);
            setHitAreaAndMask();
            selected = _selected;
         }
         setStar();
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:FurnitureTempInfo = null;
         selected = false;
         if(hitTest == false)
         {
            return false;
         }
         if(_data == null)
         {
            return false;
         }
         if((_data.templateInfo.Type == 2 || _data.templateInfo.Type == 1) && inHouse)
         {
            return false;
         }
         if(model.selectFurn)
         {
            _loc2_ = TempleteManager.instance.furnitureTemplateCate.getTempById(model.selectFurn.templateId);
            if(model.filterType(temp.Type,_loc2_.Type))
            {
               return false;
            }
            if(model.selectFurn.posX >= 0 && model.selectFurn.posY >= 0)
            {
               return false;
            }
         }
         selected = true;
         return true;
      }
      
      public function getClickEvent(param1:MouseEvent) : Boolean
      {
         var _loc2_:FriendFarmStateInfo = null;
         if(hitTest == false)
         {
            return false;
         }
         if(_data == null)
         {
            return false;
         }
         if(hasEvent)
         {
            if(model.masterId > 0)
            {
               HomeSender.clickFurniture(model.masterId);
               _loc2_ = FarmManager.instance.model.getFarmStateInfo(model.masterId);
               if(_loc2_)
               {
                  model.info.furnitureId = 0;
                  _loc2_.furnitureId = 0;
                  FriendManager.getInstance().dispatchEvent(new FriendUpdateEvent("FRIEND_UPDATE",null));
               }
               _view.buttonMode = false;
            }
         }
         ObjectUtils.disposeViolentMc(_starMc);
         _starMc = null;
         return true;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:FurnitureInfo = null;
         _selected = param1;
         if(_selected)
         {
            if(_filter && _view)
            {
               _filter.setGlowFilter(_view);
            }
            _loc2_ = new FurnitureInfo();
            _loc2_.furnitureId = _data.furnitureId;
            _loc2_.templateId = _data.templateId;
            _loc2_.posX = _data.posX;
            _loc2_.posY = _data.posY;
            _loc2_.rotation = _data.rotation;
            if(_hitBitmap)
            {
               model.opPoint.x = this.x + _hitBitmap.x;
               model.opPoint.y = this.y + _hitBitmap.y + _hitBitmap.height;
            }
            model.selectFurn = null;
            model.clickFurn = _loc2_;
         }
         else if(_view)
         {
            _view.filters = [];
         }
      }
      
      private function get hitTest() : Boolean
      {
         if(_hitBitmap)
         {
            if(_hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY) > 50)
            {
               return true;
            }
         }
         return false;
      }
      
      private function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__iconLoadComplete);
         if(_view)
         {
            _view.filters = [];
         }
         ObjectUtils.disposeObject(_hitBitmap);
         _hitBitmap = null;
         ObjectUtils.disposeViolentMc(_starContainer);
         _starContainer = null;
         ObjectUtils.disposeViolentMc(_view);
         _view = null;
         ObjectUtils.disposeViolentMc(_starMc);
         _starMc = null;
      }
      
      private function get temp() : FurnitureTempInfo
      {
         if(_data == null)
         {
            return null;
         }
         var _loc1_:int = int(_data.templateId);
         return TempleteManager.instance.furnitureTemplateCate.getTempById(_loc1_);
      }
      
      private function get model() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      public function dispose() : void
      {
         clean();
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

