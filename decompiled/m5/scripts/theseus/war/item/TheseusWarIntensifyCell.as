package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.mediator.TheseusWarIntensifyCellClickMediator;
   import theseus.mediator.TheseusWarIntensifyCellDropMediator;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MediatorMananger;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusWarIntensifyCell extends Sprite
   {
      
      public static const FUNTPYE_QH:int = 1;
      
      public static const FUNTPYE_SX:int = 2;
      
      public static const FUNTPYE_GZ:int = 3;
      
      public static const FUNTPYE_XL:int = 4;
      
      public static const FUNTPYE_JN:int = 5;
      
      public static const FUNTPYE_FJ:int = 6;
      
      public var _warEquipIntensifyCellBg:Bitmap;
      
      public var _intensifyEquipCTxt:FilterFrameText;
      
      public var _warIntensifyCellIcon:BaseIconView;
      
      private var _data:TheseusWarsoulItemInfo;
      
      private var _funType:int;
      
      public var isNormalFilter:Boolean = true;
      
      public var isDraging:Boolean = false;
      
      protected var _filter:IFilterFormat;
      
      public var isNeedMediator:Boolean;
      
      private var _isRigist:Boolean;
      
      protected var _mediatorKey:String;
      
      public const NAME:String = "theseus.war.item.TheseusInsfBagCell";
      
      private var _profile:ScaleFrameImage;
      
      private var _starItem:TheseusStarItem;
      
      private var _lockIcon:DisplayObject;
      
      public function TheseusWarIntensifyCell()
      {
         super();
         initView();
      }
      
      public function setGrayFilter() : void
      {
         if(_warIntensifyCellIcon)
         {
            _filter.setGrayFilter(_warIntensifyCellIcon);
            isNormalFilter = false;
         }
      }
      
      public function setNormalFilter() : void
      {
         if(_warIntensifyCellIcon)
         {
            _filter.setNormalFilter(_warIntensifyCellIcon);
            isNormalFilter = true;
         }
      }
      
      public function get icon() : BaseIconView
      {
         return _warIntensifyCellIcon;
      }
      
      public function get funType() : int
      {
         return _funType;
      }
      
      public function set funType(param1:int) : void
      {
         _funType = param1;
      }
      
      public function get data() : TheseusWarsoulItemInfo
      {
         return _data;
      }
      
      public function showVpLock() : void
      {
         if(_lockIcon == null)
         {
            _lockIcon = ComponentFactory.Instance.creat("asset.common.vp.icon");
            _lockIcon.x = 20;
            _lockIcon.y = 15;
            addChild(_lockIcon);
         }
         _lockIcon.visible = true;
      }
      
      public function hideVpLock() : void
      {
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      public function set data(param1:TheseusWarsoulItemInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _data.objectId = 1;
            _warIntensifyCellIcon.icon = IconFactory.getTheseusWarSoulIcon(_data.warTempInfo.Icon);
            _warIntensifyCellIcon.tipData = _data;
            if(isNeedMediator && !_isRigist)
            {
               registerMediator();
            }
            _profile.visible = true;
            _profile.setFrame(_data.warTempInfo.Profile - 1);
            _starItem.visible = true;
            _starItem.showStar(_data.star);
            if(_data && _data.isLock)
            {
               showVpLock();
            }
            else if(_data && !_data.isLock)
            {
               hideVpLock();
            }
         }
         else
         {
            hideVpLock();
            _warIntensifyCellIcon.icon = null;
            _warIntensifyCellIcon.tipData = null;
            _profile.visible = false;
            _starItem.visible = false;
         }
      }
      
      protected function registerMediator() : void
      {
         _isRigist = true;
         var _loc1_:Array = [TheseusWarIntensifyCellClickMediator,TheseusWarIntensifyCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.war.item.TheseusInsfBagCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _warEquipIntensifyCellBg = ComponentFactory.Instance.creatBitmap("asset.theseus.warEquipIntensifyCellBg");
         _intensifyEquipCTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.intensifyEquipCTxt");
         _warIntensifyCellIcon = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warIntensifyCellIcon");
         _profile = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warCell.Profile2");
         _starItem = new TheseusStarItem(10);
         addChild(_warEquipIntensifyCellBg);
         addChild(_intensifyEquipCTxt);
         addChild(_warIntensifyCellIcon);
         addChild(_profile);
         addChild(_starItem);
         _profile.visible = false;
         _starItem.visible = false;
         _starItem.x = 19;
         _starItem.y = 18;
         _intensifyEquipCTxt.text = LanguageMgr.GetTranslation("theseus.war.equipTitle");
      }
      
      public function set defaultStr(param1:String) : void
      {
         _intensifyEquipCTxt.text = param1;
      }
      
      public function dispose() : void
      {
         unregisterMediator();
         ObjectUtils.disposeObject(_warEquipIntensifyCellBg);
         _warEquipIntensifyCellBg = null;
         ObjectUtils.disposeObject(_intensifyEquipCTxt);
         _intensifyEquipCTxt = null;
         ObjectUtils.disposeObject(_warIntensifyCellIcon);
         _warIntensifyCellIcon = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         ObjectUtils.disposeObject(_starItem);
         _starItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_data)
         {
            _data.objectId = 0;
         }
         _data = null;
         _filter = null;
      }
   }
}

