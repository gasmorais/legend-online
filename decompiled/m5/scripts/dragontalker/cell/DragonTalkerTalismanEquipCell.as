package dragontalker.cell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.mediator.DragonTalkerEquipCellClickMediator;
   import dragontalker.mediator.DragonTalkerEquipCellDropMediator;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.MediatorMananger;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerTalismanEquipCell extends Component
   {
      
      public static const NAME:String = "dragontalker.cell.DragonTalkerTalismanEquipCell";
      
      private var _back:ScaleFrameImage;
      
      private var _iconItem:BaseIconView;
      
      private var _dragItem:BaseIconView;
      
      private var _profileImage:ScaleFrameImage;
      
      private var _iconSprite:Sprite;
      
      private var _gradeText:FilterFrameText;
      
      protected var _mediatorKey:String;
      
      private var _data:DragonTalkerTalismanInfo;
      
      private var _index:int;
      
      public var isNormalFilter:Boolean = true;
      
      protected var _filter:UIFilter;
      
      public function DragonTalkerTalismanEquipCell(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,45,45);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanEquipCell.back");
         _iconItem = ComponentFactory.Instance.creatCustomObject("DragonTalkerTalismanEquipCell.icon");
         _dragItem = ComponentFactory.Instance.creatCustomObject("DragonTalkerTalismanEquipCell.icon");
         _profileImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanEquipCell.profileImage");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanCell.gradeText");
         addChild(_back);
         addChild(_iconItem);
         addChild(_profileImage);
         addChild(_gradeText);
         _gradeText.x = _gradeText.y = 15;
         _back.setFrame(_index + 1);
         _profileImage.mouseChildren = _profileImage.mouseEnabled = false;
         _iconItem.mask = createSprite();
         _filter = new UIFilter();
      }
      
      private function createSprite() : Sprite
      {
         _iconSprite = new Sprite();
         _iconSprite.graphics.beginFill(16777215,1);
         _iconSprite.graphics.drawCircle(36,36,28);
         _iconSprite.graphics.endFill();
         addChild(_iconSprite);
         _iconSprite.mouseChildren = _iconSprite.mouseEnabled = false;
         return _iconSprite;
      }
      
      private function addEvent() : void
      {
         var _loc1_:Array = [DragonTalkerEquipCellClickMediator,DragonTalkerEquipCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"dragontalker.cell.DragonTalkerTalismanEquipCell");
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
            _dragItem.icon = IconFactory.getGoodsIconByTID(data.goodsTempInfo.TemplateId);
            _iconItem.tipData = data;
            _profileImage.setFrame(data.goodsTempInfo.Profile);
            _gradeText.text = data.grade > 0 ? "+" + data.grade : "";
            _gradeText.setFrame(data.goodsTempInfo.Profile);
         }
         else
         {
            _iconItem.visible = false;
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
      
      public function get dragIcon() : BaseIconView
      {
         return _dragItem;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
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
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iconItem);
         _iconItem = null;
         ObjectUtils.disposeObject(_profileImage);
         _profileImage = null;
         ObjectUtils.disposeObject(_iconSprite);
         _iconSprite = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_dragItem);
         _dragItem = null;
         _filter = null;
         super.dispose();
      }
   }
}

