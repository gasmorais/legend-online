package yishi.view.community
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.utils.StringHelper;
   
   public class BaseFriendIcon extends BaseIconView
   {
      
      public function BaseFriendIcon(param1:Function = null)
      {
         super(param1);
      }
      
      override protected function resetIconView() : void
      {
         ShowTipManager.Instance.removeTip(this);
         _iconView = null;
         if(_icon is DisplayObject)
         {
            _iconView = _icon as DisplayObject;
         }
         else if(_icon is String)
         {
            LoaderManagerII.instance.load(String(_icon),2,8,__iconLoadComplete);
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
      
      override protected function showIconView() : void
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
         if(!_iconView)
         {
            return;
         }
         if(!_loc1_)
         {
            if(_loading)
            {
               _loading.gotoAndStop(1);
               _loading.visible = false;
            }
            return;
         }
         if(_loadComplete != null)
         {
            _loadComplete(this);
            _loadComplete = null;
         }
         if(_loading)
         {
            _loading.gotoAndStop(1);
            _loading.visible = false;
         }
         ShowTipManager.Instance.addTip(this);
         if(_iconContainer)
         {
            ObjectUtils.removeChildAllChildren(_iconContainer);
            _iconContainer.addChild(_iconView as DisplayObject);
         }
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__iconLoadComplete);
         if(_iconContainer)
         {
            ObjectUtils.removeChildAllChildren(_iconContainer);
         }
         super.dispose();
      }
   }
}

