package dragontalker.cell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.mediator.DragonTalkerHandleCellClickMediator;
   import dragontalker.mediator.DragonTalkerHandleCellDropMediator;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.MediatorMananger;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerTalismanHandleCell extends Component
   {
      
      public static const NAME:String = "dragontalker.cell.DragonTalkerTalismanHandleCell";
      
      private var _cellBack:Bitmap;
      
      private var _iconItem:BaseIconView;
      
      private var _profileImage:ScaleFrameImage;
      
      private var _countText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      public var isNormalFilter:Boolean = true;
      
      protected var _filter:UIFilter;
      
      protected var _mediatorKey:String;
      
      private var _data:DragonTalkerTalismanInfo;
      
      public var cellType:int;
      
      public var posType:int;
      
      public function DragonTalkerTalismanHandleCell(param1:int, param2:int)
      {
         super();
         cellType = param1;
         posType = param2;
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,60,60);
      }
      
      private function initView() : void
      {
         _cellBack = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerTalismanHandleCell.cellBack");
         _iconItem = ComponentFactory.Instance.creatCustomObject("DragonTalkerTalismanHandleCell.icon");
         _countText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanHandleCell.countText");
         _profileImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanHandleCell.ProfileBG");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanCell.gradeText");
         addChild(_cellBack);
         addChild(_iconItem);
         addChild(_profileImage);
         addChild(_countText);
         addChild(_gradeText);
         _gradeText.x = _gradeText.y = 10;
         _profileImage.setFrame(1);
         _profileImage.visible = false;
         _profileImage.mouseChildren = _profileImage.mouseEnabled = false;
         _profileImage.scaleX = _profileImage.scaleY = 1.3333333333333333;
         _filter = new UIFilter();
      }
      
      private function addEvent() : void
      {
         var _loc1_:Array = [DragonTalkerHandleCellClickMediator,DragonTalkerHandleCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"dragontalker.cell.DragonTalkerTalismanHandleCell");
      }
      
      private function removeEvent() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function set data(param1:DragonTalkerTalismanInfo) : void
      {
         _data = param1;
         if(data)
         {
            _iconItem.visible = true;
            _profileImage.visible = true;
            _iconItem.icon = IconFactory.getGoodsIconByTID(data.goodsTempInfo.TemplateId);
            _iconItem.tipData = data;
            _profileImage.setFrame(data.goodsTempInfo.Profile);
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
            _countText.text = "";
            _iconItem.tipData = null;
            _profileImage.visible = false;
            _gradeText.text = "";
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cellBack);
         _cellBack = null;
         ObjectUtils.disposeObject(_iconItem);
         _iconItem = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_profileImage);
         _profileImage = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         _filter = null;
         super.dispose();
      }
   }
}

