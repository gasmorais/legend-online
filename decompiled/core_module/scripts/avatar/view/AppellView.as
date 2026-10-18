package avatar.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AppellEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.appell.AppellModel;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class AppellView extends Component
   {
      
      private var _url:String;
      
      private var _appellInfo:AppellInfoTemplate;
      
      public var appellWidth:Number = 0;
      
      public var appellHeight:Number = 0;
      
      private var _appellText:FilterFrameText;
      
      private var _title:GradientText;
      
      private var _appellContainer:Sprite;
      
      public function AppellView(param1:AppellInfoTemplate)
      {
         super();
         _appellContainer = new Sprite();
         addChild(_appellContainer);
         _appellInfo = param1;
         if(_appellInfo && _appellInfo.colorId != 14)
         {
            addTitle();
         }
         if(!param1)
         {
            return;
         }
         var _loc2_:Array = _appellInfo.ShowParam.split(",");
         if(_loc2_.length >= 4)
         {
            appellWidth = _appellInfo.ImgWidth;
            appellHeight = _appellInfo.ImgHeight;
            _url = PathManager.getAppellPicPath(_appellInfo.ImgId + "");
            initLoad();
         }
      }
      
      private function initLoad() : void
      {
         var _loc1_:int = 5;
         if(LoaderManagerII.instance.isLoaded(_url))
         {
            _loc1_ = 0;
         }
         LoaderManagerII.instance.load(_url,2,_loc1_,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 is Bitmap)
         {
            initView(param2 as Bitmap);
         }
      }
      
      override public function get width() : Number
      {
         return appellWidth;
      }
      
      override public function get height() : Number
      {
         return appellHeight;
      }
      
      private function addTitle() : void
      {
         if(!_appellInfo)
         {
            return;
         }
         _title = ComponentFactory.Instance.creatComponentByStylename("appell.apellTitleText");
         _title.colors = AppellModel.COLORS[_appellInfo.colorId - 1];
         var _loc1_:String = _appellInfo.htmlTitle;
         _title.x = _appellInfo.ImgWidth / 2 - 130;
         var _loc3_:RegExp = /\n/g;
         var _loc4_:Array = _loc1_.match(_loc3_);
         var _loc2_:int = _loc4_.length + 1;
         _title.textField.height = 22 * _loc2_;
         _title.height = 22 * _loc2_;
         _title.y = _appellInfo.txtY - _title.height * 0.5;
         _title.htmlText = "<font size=\'" + _appellInfo.fontSize + "\'>" + _loc1_ + "</font>";
         _title.textSize = _title.textSize;
         if(_appellInfo.IsTitleHide == 0)
         {
            _title.visible = true;
            addChild(_title);
         }
         else
         {
            _title.visible = false;
         }
      }
      
      private function initView(param1:Bitmap) : void
      {
         if(_appellContainer)
         {
            _appellContainer.addChild(param1);
         }
         NotificationManager.instance.dispatchEvent(new AppellEvent("APPELL_LOAD_COMPLETE"));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _appellInfo = null;
         ObjectUtils.disposeObject(_appellText);
         _appellText = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeAllChildren(_appellContainer);
         ObjectUtils.disposeObject(_appellContainer);
         _appellContainer = null;
      }
   }
}

