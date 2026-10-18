package theseus.warFrame.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.warFrame.mediator.WarFrameCellClickMediator;
   import theseus.warFrame.mediator.WarFrameCellDropMediator;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MediatorMananger;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class WarframeQhCell extends Sprite
   {
      
      public static const EventWarFrameInsPutIn:String = "EventWarFrameInsPutIn";
      
      public static const EventWarFrameInsPutOut:String = "EventWarFrameInsPutOut";
      
      public static const FUNTPYE_QH:int = 1;
      
      public static const FUNTPYE_GZ:int = 3;
      
      public var _warEquipIntensifyCellBg:Bitmap;
      
      public var _intensifyEquipCTxt:FilterFrameText;
      
      public var _warIntensifyCellIcon:BaseIconView;
      
      private var _data:WarFrameItemInfo;
      
      private var _funType:int;
      
      public var isNormalFilter:Boolean = true;
      
      public var isDraging:Boolean = false;
      
      protected var _filter:IFilterFormat;
      
      public var isNeedMediator:Boolean;
      
      private var _isRigist:Boolean;
      
      protected var _mediatorKey:String;
      
      public const NAME:String = "theseus.item.TheseusBagCell";
      
      private var _profile:ScaleFrameImage;
      
      public function WarframeQhCell()
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
      
      public function get data() : WarFrameItemInfo
      {
         return _data;
      }
      
      public function set data(param1:WarFrameItemInfo) : void
      {
         _data = param1;
         if(_data)
         {
            mouseEnabled = true;
            mouseChildren = true;
            _warIntensifyCellIcon.icon = IconFactory.getGoodsIconByTID(_data.warTempInfo.TemplateId);
            _warIntensifyCellIcon.tipStyle = "yishi.view.tips.goods.TheseusEquipTip";
            _warIntensifyCellIcon.tipData = _data;
            if(isNeedMediator && !_isRigist)
            {
               registerMediator();
            }
            _profile.visible = true;
            _profile.setFrame(_data.warReformTempInfo.Quality - 1);
         }
         else
         {
            _warIntensifyCellIcon.icon = null;
            _warIntensifyCellIcon.tipData = null;
            _profile.visible = false;
         }
      }
      
      protected function registerMediator() : void
      {
         _isRigist = true;
         var _loc1_:Array = [WarFrameCellClickMediator,WarFrameCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.item.TheseusBagCell");
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
         _warIntensifyCellIcon = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warFrameCellIcon");
         _profile = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warCell.Profile2");
         addChild(_warEquipIntensifyCellBg);
         addChild(_intensifyEquipCTxt);
         addChild(_warIntensifyCellIcon);
         addChild(_profile);
         _profile.visible = false;
         _intensifyEquipCTxt.text = LanguageMgr.GetTranslation("theseus.warFrame.intensifyTxt3");
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

