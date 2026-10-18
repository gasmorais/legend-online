package dragontalker.cell
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.mediator.DragonTalkerBagCellClickMediator;
   import dragontalker.mediator.DragonTalkerBagCellDropMediator;
   import dragontalker.mediator.DragonTalkerBagCellLightMediator;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.MediatorMananger;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerTalismanBagCell extends Component implements IManualSize
   {
      
      public static const NAME:String = "dragontalker.cell.DragonTalkerTalismanBagCell";
      
      private var _back:ScaleBitmapImage;
      
      private var _iconItem:BaseIconView;
      
      private var _countText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _profileImage:ScaleFrameImage;
      
      private var _equipIcon:Image;
      
      private var _isNewImage:Image;
      
      public var isNormalFilter:Boolean = true;
      
      protected var _filter:UIFilter;
      
      protected var _mediatorKey:String;
      
      private var _data:DragonTalkerTalismanInfo;
      
      private var _colorMatrix:Array;
      
      private var _colorFilter:ColorMatrixFilter;
      
      public var cellType:int;
      
      private var preTempId:int;
      
      public function DragonTalkerTalismanBagCell()
      {
         super();
         initView();
         addEvent();
         _colorMatrix = [0.2,0,0,0,6.1,0,0.2,0,0,6.1,0,0,0.2,0,6.1,0,0,0,1,0];
         _colorFilter = new ColorMatrixFilter(_colorMatrix);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,45,45);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("core.ItemBack");
         _iconItem = ComponentFactory.Instance.creatCustomObject("DragonTalkerTalismanBagCell.icon");
         _profileImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanBagCell.ProfileBG");
         _countText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanBagCell.countText");
         _equipIcon = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanBagCell.equipIcon");
         _isNewImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanBagCell.isNewImage");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanCell.gradeText");
         addChild(_back);
         addChild(_iconItem);
         addChild(_profileImage);
         addChild(_equipIcon);
         addChild(_isNewImage);
         addChild(_countText);
         addChild(_gradeText);
         _profileImage.setFrame(1);
         _profileImage.visible = false;
         _profileImage.mouseChildren = _profileImage.mouseEnabled = false;
         _filter = new UIFilter();
         _equipIcon.visible = false;
         _isNewImage.visible = false;
         _equipIcon.mouseChildren = _equipIcon.mouseEnabled = false;
         _isNewImage.mouseChildren = _isNewImage.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         var _loc1_:Array = [DragonTalkerBagCellClickMediator,DragonTalkerBagCellDropMediator,DragonTalkerBagCellLightMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"dragontalker.cell.DragonTalkerTalismanBagCell");
      }
      
      private function removeEvent() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function set data(param1:DragonTalkerTalismanInfo) : void
      {
         _data = param1;
         initFilter();
         if(data)
         {
            if(model.isInMutiInstensifyList(data))
            {
               setDarkFilter();
            }
            _iconItem.visible = true;
            _profileImage.visible = true;
            if(preTempId != data.goodsTempInfo.TemplateId)
            {
               _iconItem.icon = IconFactory.getGoodsIconByTID(data.goodsTempInfo.TemplateId);
            }
            preTempId = data.goodsTempInfo.TemplateId;
            _iconItem.tipData = data;
            _profileImage.setFrame(data.goodsTempInfo.Profile);
            _equipIcon.visible = data.isEquip;
            _isNewImage.visible = data.isNew && !data.isExpType;
            _gradeText.text = data.grade > 0 ? "+" + data.grade : "";
            _gradeText.setFrame(data.goodsTempInfo.Profile);
            if(data.isExpType)
            {
               _iconItem.tipStyle = "yishi.view.tips.DragonTalkerTalismanExpTips";
               _countText.text = data.count + "";
            }
            else
            {
               _iconItem.tipStyle = "yishi.view.tips.DragonTalkerTalismanContrastTips";
               _countText.text = "";
            }
         }
         else
         {
            _iconItem.visible = false;
            _profileImage.visible = false;
            _countText.text = "";
            _gradeText.text = "";
            _iconItem.tipData = null;
            _equipIcon.visible = false;
            _isNewImage.visible = false;
         }
      }
      
      public function get data() : DragonTalkerTalismanInfo
      {
         return _data;
      }
      
      public function get icon() : BaseIconView
      {
         return _iconItem;
      }
      
      public function setGrayFilter() : void
      {
         if(_iconItem)
         {
            _filter.setGrayFilter(_iconItem);
            isNormalFilter = false;
         }
      }
      
      public function setNormalFilter() : void
      {
         if(_iconItem)
         {
            _filter.setNormalFilter(_iconItem);
            isNormalFilter = true;
         }
      }
      
      public function setDarkFilter() : void
      {
         filters = [_colorFilter];
      }
      
      public function setBrightFilter() : void
      {
         filters = null;
      }
      
      private function initFilter() : void
      {
         if(_data && GoodsManager.instance.isSellPos(_data.goodInfo))
         {
            setDarkFilter();
         }
         else
         {
            setBrightFilter();
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iconItem);
         _iconItem = null;
         ObjectUtils.disposeObject(_profileImage);
         _profileImage = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_equipIcon);
         _equipIcon = null;
         ObjectUtils.disposeObject(_isNewImage);
         _isNewImage = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         _filter = null;
         super.dispose();
      }
   }
}

