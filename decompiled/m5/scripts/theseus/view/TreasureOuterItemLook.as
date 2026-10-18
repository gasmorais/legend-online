package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TreasureOuterItemLook extends Component implements ISelectable
   {
      
      protected var _bg:Bitmap;
      
      protected var _light:Bitmap;
      
      protected var _lock:Bitmap;
      
      protected var _icon:BaseIconView;
      
      private var _selected:Boolean;
      
      protected var _index:int;
      
      private var _data:GoodsInfo;
      
      protected var _effect:MovieImage;
      
      private var _thane:ThaneInfo;
      
      public function TreasureOuterItemLook(param1:int)
      {
         super();
         _index = param1;
         initView();
         this.buttonMode = true;
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.tipDirctions = "0";
         this.tipGapH = 0;
         this.tipGapV = 5;
         this.isFollowMouse = false;
      }
      
      public function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.outerBg");
         _light = ComponentFactory.Instance.creatBitmap("asset.theseus.outerLight");
         _lock = ComponentFactory.Instance.creatBitmap("asset.theseus.outerLock");
         _icon = ComponentFactory.Instance.creatCustomObject("TreasureOuterItem.icon");
         _effect = ComponentFactory.Instance.creatComponentByStylename("core.goods.Strengthen");
         addChild(_bg);
         addChild(_icon);
         addChild(_light);
         _light.visible = false;
         addChild(_effect);
         _effect.visible = false;
         addChild(_lock);
         _icon.mask = createSprite();
         _effect.x = 30;
         _effect.y = 30;
      }
      
      public function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(26,26,22);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function refreshLock() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(model.hokeInfo)
         {
            _loc1_ = model.hokeInfo.split(",");
         }
         if(_loc1_[_index])
         {
            _loc2_ = int(_loc1_[_index]);
            _lock.visible = _loc2_ == 0;
         }
         else
         {
            _lock.visible = model.coreLevel == 0;
         }
      }
      
      public function get isLock() : Boolean
      {
         return _lock.visible;
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(_effect)
         {
            _effect.visible = false;
         }
         if(!_data)
         {
            _icon.icon = null;
            return;
         }
         _icon.icon = IconFactory.getGoodsIconByTID(_data.templateId);
         if(_data.templateInfo.StrengthenMax != 0 && _data.strengthenGrade == _data.templateInfo.StrengthenMax)
         {
            if(_effect)
            {
               _effect.visible = true;
            }
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:GoodsInfo = null;
         if(_thane.equipDic)
         {
            for each(var _loc1_:Object in _thane.equipDic)
            {
               if(_loc1_ is GoodsInfo)
               {
                  if((_loc1_ as GoodsInfo).bagType == 39)
                  {
                     if((_loc1_ as GoodsInfo).pos == _index)
                     {
                        _loc2_ = _loc1_ as GoodsInfo;
                     }
                  }
               }
            }
         }
         data = _loc2_;
      }
      
      public function initData(param1:ThaneInfo) : void
      {
         _thane = param1;
         refreshLock();
         refreshView();
      }
      
      public function get model() : TheseussoulModel
      {
         return _thane.theseusInfo;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _light.visible = _selected;
      }
      
      public function get type() : int
      {
         return 750;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

