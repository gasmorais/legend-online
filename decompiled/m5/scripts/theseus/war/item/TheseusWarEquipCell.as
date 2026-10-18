package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.mediator.TheseusWarEquipCellClickMediator;
   import theseus.war.mediator.TheseusWarEquipCellDropMediator;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MediatorMananger;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusWarEquipCell extends Sprite
   {
      
      public static const NAME:String = "theseus.war.item.TheseusWarEquipCell";
      
      public var _mediatorKey:String;
      
      public var _warCellIcon:BaseIconView;
      
      public var _warBoxLock:Image;
      
      public var _warCellTxt:FilterFrameText;
      
      public var _warBoxBg:Bitmap;
      
      private var _sonType:int;
      
      private var _isLock:Boolean = true;
      
      private var _data:TheseusWarsoulItemInfo;
      
      private var _profile:ScaleFrameImage;
      
      private var _lockIcon:DisplayObject;
      
      public var isNormalFilter:Boolean = true;
      
      public var isDraging:Boolean = false;
      
      protected var _filter:IFilterFormat;
      
      private var _starItem:TheseusStarItem;
      
      protected var relativeLockPos:int = 15;
      
      public function TheseusWarEquipCell(param1:int)
      {
         super();
         _filter = new UIFilter();
         _sonType = param1;
         initView();
         var _loc2_:int = int(RoyaltyBossManager.instance.model.royaltyLevel);
         var _loc3_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc2_);
         if(_loc3_ && _loc3_.OpenWarSoul >= _sonType)
         {
            isLock = false;
         }
      }
      
      public function hideVpLock() : void
      {
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      public function showVpLock() : void
      {
         if(_lockIcon == null)
         {
            _lockIcon = ComponentFactory.Instance.creat("asset.common.vp.icon");
            addChild(_lockIcon);
            if(relativeLockPos > 0)
            {
               _lockIcon.x = relativeLockPos;
               _lockIcon.y = relativeLockPos;
            }
         }
         _lockIcon.visible = true;
      }
      
      public function get sonType() : int
      {
         return _sonType;
      }
      
      public function setGrayFilter() : void
      {
         if(_warCellIcon)
         {
            _filter.setGrayFilter(_warCellIcon);
            isNormalFilter = false;
         }
      }
      
      public function setNormalFilter() : void
      {
         if(_warCellIcon)
         {
            _filter.setNormalFilter(_warCellIcon);
            isNormalFilter = true;
         }
      }
      
      public function get icon() : BaseIconView
      {
         return _warCellIcon;
      }
      
      private function initView() : void
      {
         var _loc1_:Array = null;
         _warCellIcon = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warCellIcon");
         _warBoxLock = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warBoxLock");
         _warCellTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warCellTxt");
         _warBoxBg = ComponentFactory.Instance.creatBitmap("asset.theseus.warBoxBg");
         _profile = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warCell.Profile");
         _starItem = new TheseusStarItem(10);
         addChild(_warBoxBg);
         addChild(_warCellTxt);
         addChild(_warCellIcon);
         addChild(_warBoxLock);
         addChild(_profile);
         addChild(_starItem);
         _profile.visible = false;
         _starItem.visible = false;
         _starItem.x = 13;
         _starItem.y = 17;
         _warCellTxt.text = LanguageMgr.GetTranslation("theseus.war.equipCell" + _sonType);
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("warsoul_open_tips");
         if(_loc2_)
         {
            _loc1_ = _loc2_.ConfigValue.split(",");
            _warBoxLock.tipData = LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_[_sonType - 1]);
         }
      }
      
      protected function registerMediator() : void
      {
         _warBoxLock.visible = false;
         var _loc1_:Array = [TheseusWarEquipCellClickMediator,TheseusWarEquipCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.war.item.TheseusWarEquipCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function dispose() : void
      {
         unregisterMediator();
         ObjectUtils.disposeObject(_warCellIcon);
         _warCellIcon = null;
         ObjectUtils.disposeObject(_warBoxLock);
         _warBoxLock = null;
         ObjectUtils.disposeObject(_warCellTxt);
         _warCellTxt = null;
         ObjectUtils.disposeObject(_warBoxBg);
         _warBoxBg = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         ObjectUtils.disposeObject(_starItem);
         _starItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         if(!_isLock)
         {
            registerMediator();
         }
      }
      
      public function get data() : TheseusWarsoulItemInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusWarsoulItemInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _warCellTxt.visible = false;
            _warCellIcon.visible = true;
            _warCellIcon.icon = IconFactory.getTheseusWarSoulIcon(_data.warTempInfo.Icon);
            _warCellIcon.tipData = _data;
            _profile.visible = true;
            _profile.setFrame(_data.warTempInfo.Profile - 1);
            _starItem.visible = true;
            _starItem.showStar(_data.star);
            if(_data.isLock)
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
            _warCellTxt.visible = true;
            _warCellIcon.visible = false;
            _profile.visible = false;
            _starItem.visible = false;
         }
      }
   }
}

