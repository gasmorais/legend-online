package yishi.view.community
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import yishi.utils.StringHelper;
   
   public class BaseIconView extends TransformableComponent implements IManualTipTargetSize
   {
      
      public static const P_icon:String = "icon";
      
      public static const P_iconWidth:String = "iconWidth";
      
      public static const P_iconHeight:String = "iconHeight";
      
      public static const P_loading:String = "loading";
      
      public static const P_loadingHeight:String = "loadingHeight";
      
      public static const P_loadingWidth:String = "loadingWidth";
      
      public static const P_loadingX:String = "loadingX";
      
      public static const P_loadingY:String = "loadingY";
      
      public static const P_smoothing:String = "smoothing";
      
      public static const P_iconBackStyle:String = "iconBackStyle";
      
      private static const _iconDic:Dictionary = new Dictionary();
      
      private var _iconViewWidth:int;
      
      private var _iconViewHeight:int;
      
      private var _loadingWidth:int;
      
      private var _loadingHeight:int;
      
      private var _loadingX:int;
      
      private var _loadingY:int;
      
      private var _smoothing:Boolean = true;
      
      public var pos:int;
      
      protected var _iconContainer:Sprite;
      
      protected var _icon:Object;
      
      protected var _iconView:DisplayObject;
      
      protected var _loading:MovieClip;
      
      protected var _loadComplete:Function;
      
      private var _loadingStyle:String;
      
      private var _iconBackStyle:String;
      
      public function BaseIconView(param1:Function = null)
      {
         super();
         _iconContainer = new Sprite();
         _loadComplete = param1;
      }
      
      public function set icon(param1:Object) : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _icon = param1;
         onPropertiesChanged("icon");
      }
      
      public function get icon() : Object
      {
         return _icon;
      }
      
      public function set iconWidth(param1:int) : void
      {
         _iconViewWidth = param1;
         onPropertiesChanged("iconWidth");
      }
      
      public function get iconWidth() : int
      {
         return _iconViewWidth;
      }
      
      public function set iconHeight(param1:int) : void
      {
         _iconViewHeight = param1;
         onPropertiesChanged("iconHeight");
      }
      
      public function get iconHeight() : int
      {
         return _iconViewHeight;
      }
      
      public function set loadingStyle(param1:String) : void
      {
         _loadingStyle = param1;
         onPropertiesChanged("loading");
      }
      
      public function set loadingWidth(param1:int) : void
      {
         _loadingWidth = param1;
         onPropertiesChanged("loadingWidth");
      }
      
      public function set loadingHeight(param1:int) : void
      {
         _loadingHeight = param1;
         onPropertiesChanged("loadingHeight");
      }
      
      public function set loadingX(param1:int) : void
      {
         _loadingX = param1;
         onPropertiesChanged("loadingX");
      }
      
      public function set loadingY(param1:int) : void
      {
         _loadingY = param1;
         onPropertiesChanged("loadingY");
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         if(_smoothing == param1)
         {
            return;
         }
         _smoothing = param1;
         onPropertiesChanged("smoothing");
      }
      
      public function get iconBackStyle() : String
      {
         return _iconBackStyle;
      }
      
      public function set iconBackStyle(param1:String) : void
      {
         if(_iconBackStyle == param1)
         {
            return;
         }
         _iconBackStyle = param1;
         onPropertiesChanged("iconBackStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["icon"] || _changedPropeties["iconWidth"] || _changedPropeties["iconHeight"])
         {
            resetIconView();
         }
         if(!_changedPropeties)
         {
            return;
         }
         if(_changedPropeties["loading"])
         {
            ObjectUtils.disposeViolentMc(_loading);
            _loading = null;
            _loading = ComponentFactory.Instance.creat(_loadingStyle);
            _loading.gotoAndStop(1);
            _loading.visible = false;
         }
         if(_changedPropeties["loadingHeight"] || _changedPropeties["loadingWidth"] || _changedPropeties["loadingX"] || _changedPropeties["loadingY"])
         {
            if(_loading)
            {
               _loading.width = _loadingWidth;
               _loading.height = _loadingHeight;
               _loading.x = _loadingX;
               _loading.y = _loadingY;
            }
         }
         if(_changedPropeties["smoothing"] && _iconView && _iconView is Bitmap)
         {
            (_iconView as Bitmap).smoothing = _smoothing;
         }
      }
      
      override protected function addChildren() : void
      {
         if(_iconContainer)
         {
            addChild(_iconContainer);
         }
         if(_loading)
         {
            addChild(_loading);
            _loading.mouseChildren = _loading.mouseEnabled = false;
         }
      }
      
      protected function resetIconView() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__iconLoadComplete);
         ShowTipManager.Instance.removeTip(this);
         clearIconView();
         ObjectUtils.disposeViolentMc(_iconContainer);
         if(_icon is DisplayObject)
         {
            _iconView = _icon as DisplayObject;
         }
         else if(_icon is String)
         {
            _icon = String(_icon).toLowerCase();
            if(_iconDic[_icon])
            {
               _iconView = new Bitmap((_iconDic[_icon] as BitmapData).clone());
            }
            else
            {
               if(_loading)
               {
                  _loading.gotoAndPlay(1);
                  _loading.visible = true;
               }
               LoaderManagerII.instance.load(String(_icon),2,8,__iconLoadComplete);
            }
         }
         else if(_icon is BitmapData)
         {
            _iconView = new Bitmap(BitmapData(_icon));
         }
         else if(_icon is Class)
         {
            _iconView = new _icon();
         }
         else
         {
            _iconView = new Sprite();
         }
         showIconView();
      }
      
      protected function updateIconView() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:Sprite = null;
         var _loc4_:BitmapData = null;
         if(!_iconView)
         {
            return;
         }
         if(iconWidth != 0 || iconHeight != 0)
         {
            _loc2_ = _iconView.width;
            _loc5_ = _iconView.height;
            if(_iconView is Bitmap && _iconBackStyle)
            {
               _loc3_ = ComponentFactory.Instance.creat(_iconBackStyle);
               _iconView.width = _loc3_.width - 4;
               _iconView.height = _loc3_.height - 4;
               _iconView.x = 2;
               _iconView.y = 2;
               _loc1_ = new Sprite();
               _loc1_.addChild(_loc3_);
               _loc1_.addChild(_iconView);
               _loc4_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
               _loc4_.draw(_loc1_);
               _loc1_.removeChild(_loc3_);
               _loc1_.removeChild(_iconView);
               ObjectUtils.disposeObject(_loc3_);
               ObjectUtils.disposeObject(_iconView);
               _iconView = new Bitmap(_loc4_);
            }
            _iconView.width = iconWidth;
            _iconView.height = iconHeight;
         }
      }
      
      protected function showIconView() : void
      {
         var _loc1_:Boolean = false;
         updateIconView();
         if(_icon is String)
         {
            _loc1_ = !StringHelper.isNullOrEmpty(_icon as String);
         }
         else
         {
            _loc1_ = !!_icon;
         }
         ShowTipManager.Instance.addTip(this);
         if(!_iconView)
         {
            return;
         }
         if(!_loc1_)
         {
            if(_loading)
            {
               _loading.gotoAndStop(1);
               if(_loading)
               {
                  _loading.visible = false;
               }
            }
            return;
         }
         if(_loadComplete != null)
         {
            _loadComplete(this);
         }
         if(_loading)
         {
            _loading.gotoAndStop(1);
            _loading.visible = false;
         }
         if(_iconView is Bitmap)
         {
            (_iconView as Bitmap).smoothing = _smoothing;
         }
         if(_iconContainer)
         {
            _iconContainer.addChild(_iconView);
         }
      }
      
      protected function __iconLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_icon || isDie || String(_icon) != param1.url)
         {
            return;
         }
         clearIconView();
         if(!_iconDic[_icon] && param2 is Bitmap)
         {
            _iconDic[_icon] = (param2 as Bitmap).bitmapData.clone();
         }
         if(param2 is Bitmap)
         {
            (param2 as Bitmap).smoothing = _smoothing;
            _iconView = param2 as Bitmap;
            showIconView();
         }
         else if(param2 is MovieClip)
         {
            _iconView = (param2 as MovieClip).getChildAt(0);
            if(_iconView.parent)
            {
               _iconView.parent.removeChild(_iconView);
            }
            (param2 as MovieClip).loaderInfo.loader.unloadAndStop(true);
            showIconView();
         }
      }
      
      public function get manualHeight() : Number
      {
         return _iconViewHeight;
      }
      
      public function get manualWidth() : Number
      {
         return _iconViewWidth;
      }
      
      public function get content() : DisplayObject
      {
         return _iconView;
      }
      
      private function clearIconView() : void
      {
         if(_iconView is DisplayObjectContainer)
         {
            ObjectUtils.disposeViolentMc(_iconView as DisplayObjectContainer);
         }
         else
         {
            ObjectUtils.disposeObject(_iconView);
         }
         _iconView = null;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__iconLoadComplete);
         tipData = null;
         ShowTipManager.Instance.removeTip(this);
         _loadComplete = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         clearIconView();
         ObjectUtils.disposeViolentMc(_iconContainer);
         _iconContainer = null;
         ObjectUtils.disposeViolentMc(_loading);
         _loading = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

