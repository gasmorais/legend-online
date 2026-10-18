package view.inside
{
   import avatar.view.ShowAvatar;
   import bag.helper.GoodsCheck;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MountAvatarPathHelper;
   import yishi.utils.ThaneEquipShowHelper;
   
   public class ShopAvatarFrame extends Frame implements IManualSize
   {
      
      private var _bg:Image;
      
      private var _txt:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _data:GoodsInfo;
      
      private var _showAvatar:ShowAvatar;
      
      private var _mountMovieClip:MovieClip;
      
      private var _sprite:Sprite;
      
      public function ShopAvatarFrame(param1:GoodsInfo)
      {
         super();
         _data = param1;
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,629,386);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shopAvatarFrame.bg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("shopAvatarFrame.txt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("shopAvatarFrame.btn");
         _showAvatar = ComponentFactory.Instance.creatCustomObject("shopAvatarFrame.ShowAvatar");
         _sprite = new Sprite();
         _sprite.x = 220;
         _sprite.y = 90;
         addToContent(_bg);
         addToContent(_showAvatar);
         addToContent(_sprite);
         addToContent(_txt);
         addToContent(_btn);
         refreshView();
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function refreshView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc3_:MountTemplate = null;
         var _loc2_:String = null;
         if(!_data)
         {
            return;
         }
         _txt.text = _data.templateInfo.TemplateName;
         if(GoodsCheck.isFashion(_data.templateInfo))
         {
            _loc1_ = _data.templateInfo;
            if(_loc1_ && _loc1_.Job == "99")
            {
               _showAvatar.data = createDragonTalkerInfo(_loc1_);
            }
            else if(fashionModel.lookDragonTalkerFashion)
            {
               fashionModel.lookDragonTalkerFashion = false;
               _showAvatar.data = createThaneInfo(_loc1_);
               fashionModel.lookDragonTalkerFashion = true;
            }
            else
            {
               _showAvatar.data = createThaneInfo(_loc1_);
            }
         }
         else if(_data.templateInfo.SonType == 218)
         {
            _loc3_ = TempleteManager.instance.mountTemplateDic[_data.templateInfo.Property1];
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _loc2_ = MountAvatarPathHelper.getUrl(_loc3_.AvatarPath);
            LoaderManagerII.instance.load(_loc2_,2,4,__onLoaded);
         }
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:BitmapData = null;
         var _loc3_:Rectangle = null;
         if(param2 != null)
         {
            if(_mountMovieClip)
            {
               _mountMovieClip.stop();
               _mountMovieClip.parent && _mountMovieClip.parent.removeChild(_mountMovieClip);
            }
            _mountMovieClip = param2 as MovieClip;
            if(_mountMovieClip)
            {
               _mountMovieClip.gotoAndStop(1);
               _loc4_ = new BitmapData(500,500,true,0);
               _loc4_.draw(_mountMovieClip);
               _loc3_ = _loc4_.getColorBoundsRect(4278190080,0,false);
               _sprite.addChild(_mountMovieClip);
               _mountMovieClip.x = int((210 - _loc3_.width) / 2) - _loc3_.x;
               _mountMovieClip.y = int((210 - _loc3_.height) / 2) - _loc3_.y;
               _mountMovieClip.gotoAndPlay(1);
               _loc4_.dispose();
               _loc4_ = null;
            }
         }
      }
      
      private function createDragonTalkerInfo(param1:GoodsTemplateInfo) : ThaneInfo
      {
         var _loc2_:ThaneInfo = new ThaneInfo();
         ObjectUtils.copyProperties(_loc2_,thaneInfo);
         _loc2_.templateId = thaneInfo.templateId;
         var _loc4_:Dictionary = ArmyManager.instance.dragonFashionList;
         var _loc3_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc7_:GoodsInfo = _loc4_[8];
         var _loc5_:GoodsInfo = _loc4_[9];
         var _loc8_:GoodsInfo = _loc4_[10];
         var _loc6_:GoodsInfo = _loc4_[11];
         if(_loc3_ && !_loc3_.isHidendDragonWingAvata)
         {
            _loc2_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc3_ && !_loc3_.isHidenDragonArmAvata)
         {
            _loc2_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc6_);
         }
         if(_loc3_ && !_loc3_.isHidenDragonClothAvata)
         {
            _loc2_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc8_);
         }
         if(_loc3_ && !_loc3_.isHidenDragonHatAvat)
         {
            _loc2_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         switch(int(param1.SonType) - 109)
         {
            case 0:
               _loc2_.wingAvata = param1.Avata;
               break;
            case 1:
               _loc2_.hairFashionAvata = param1.Avata;
               break;
            case 2:
               _loc2_.armsFashionAvata = param1.Avata;
               break;
            case 3:
               _loc2_.bodyFashionAvata = param1.Avata;
         }
         return _loc2_;
      }
      
      private function createThaneInfo(param1:GoodsTemplateInfo) : ThaneInfo
      {
         var _loc3_:GoodsInfo = null;
         var _loc10_:GoodsInfo = null;
         var _loc2_:ThaneInfo = new ThaneInfo();
         ObjectUtils.copyProperties(_loc2_,thaneInfo);
         _loc2_.templateId = thaneInfo.templateId;
         var _loc9_:int = int(ArmyManager.instance.thane.id);
         _loc3_ = GoodsManager.instance.getItemByPOB(0,_loc9_,4);
         _loc10_ = GoodsManager.instance.getItemByPOB(2,_loc9_,4);
         if(_loc10_)
         {
            _loc2_.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc10_);
         }
         if(_loc3_)
         {
            _loc2_.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         var _loc6_:Dictionary = ArmyManager.instance.fashionList;
         var _loc4_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc8_:GoodsInfo = _loc6_[8];
         var _loc5_:GoodsInfo = _loc6_[9];
         var _loc11_:GoodsInfo = _loc6_[10];
         var _loc7_:GoodsInfo = _loc6_[11];
         if(_loc4_ && !_loc4_.isHidenWingAvata)
         {
            _loc2_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc8_);
         }
         if(_loc4_ && !_loc4_.isHidenArmAvata)
         {
            _loc2_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc4_ && !_loc4_.isHidenClothAvata)
         {
            _loc2_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc11_);
         }
         if(_loc4_ && !_loc4_.isHidenHatAvat)
         {
            _loc2_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         switch(int(param1.SonType) - 109)
         {
            case 0:
               _loc2_.wingAvata = param1.Avata;
               break;
            case 1:
               _loc2_.hairFashionAvata = param1.Avata;
               break;
            case 2:
               _loc2_.armsFashionAvata = param1.Avata;
               break;
            case 3:
               _loc2_.bodyFashionAvata = param1.Avata;
         }
         return _loc2_;
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_showAvatar);
         _showAvatar = null;
         ObjectUtils.disposeViolentMc(_mountMovieClip);
         _mountMovieClip = null;
         ObjectUtils.disposeViolentMc(_sprite);
         _sprite = null;
         super.dispose();
      }
   }
}

