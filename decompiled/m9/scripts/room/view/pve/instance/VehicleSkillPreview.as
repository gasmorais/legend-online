package room.view.pve.instance
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.ButtonSkiner;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.component.TileContainer;
   
   public class VehicleSkillPreview extends Component
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _title:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _arrow:Bitmap;
      
      private var _box:TileContainer;
      
      private var _switchBtn:Sprite;
      
      private var _expand:Boolean = true;
      
      private var _frameFilter:Array;
      
      private var _skinArr:Array;
      
      public function VehicleSkillPreview()
      {
         super();
         initView();
         addEvent();
         __stageResizeHandler();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:VehicleSkillTempInfo = null;
         var _loc3_:BaseIconView = null;
         var _loc5_:ButtonSkiner = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("VehicleSkillListView.BackGround");
         _border.height = 195;
         _title = ComponentFactory.Instance.creatBitmap("asset.room.skillListText");
         _title.x = 48;
         _title.y = 7;
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.room.skillListTextBg");
         _titleBg.y = 5;
         _arrow = ComponentFactory.Instance.creatBitmap("asset.room.skillListTextArrow");
         _arrow.x = 90;
         _arrow.y = 5;
         _box = new TileContainer(true);
         _box.columnCount = _box.rowCount = 3;
         _box.x = 10;
         _box.y = 35;
         var _loc1_:Array = [];
         var _loc6_:Dictionary = TempleteManager.instance.vehicleSkillTempteCate.getTemplates();
         for each(var _loc7_:VehicleSkillTempInfo in _loc6_)
         {
            _loc1_.push(_loc7_);
         }
         _loc1_.sortOn("TemplateId",16);
         _skinArr = [];
         _loc4_ = 0;
         while(_loc4_ < 9)
         {
            _loc2_ = _loc1_[_loc4_];
            _loc3_ = ComponentFactory.Instance.creatCustomObject("vehicle.SkillItemView");
            _loc3_.icon = IconFactory.getCommonIconPath("/stone_05.png");
            _loc3_.buttonMode = true;
            _box.appendItem(_loc3_);
            _loc5_ = new ButtonSkiner(_loc3_);
            _loc5_.onNormalView = __normal;
            _loc5_.onOverView = __onMouseOver;
            _loc5_.data = _loc3_;
            _skinArr.push(_loc5_);
            _loc4_++;
         }
         addChild(_border);
         addChild(_titleBg);
         addChild(_title);
         addChild(_box);
         _switchBtn = new Sprite();
         _switchBtn.graphics.beginFill(16777215,0);
         _switchBtn.graphics.drawRect(0,0,105,22);
         _switchBtn.graphics.endFill();
         _switchBtn.buttonMode = true;
         _switchBtn.x = 30;
         _switchBtn.y = 8;
         _switchBtn.addChild(_arrow);
         addChild(_switchBtn);
         _frameFilter = ComponentFactory.Instance.creatFrameFilters("core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter");
      }
      
      private function __normal(param1:ButtonSkiner) : void
      {
         param1.data.filters = _frameFilter[0];
      }
      
      private function __onMouseOver(param1:ButtonSkiner) : void
      {
         param1.data.filters = _frameFilter[1];
      }
      
      private function addEvent() : void
      {
         _switchBtn.addEventListener("click",__onClickHandler);
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
      }
      
      private function removeEvent() : void
      {
         _switchBtn.removeEventListener("click",__onClickHandler);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         _expand = !_expand;
         if(_expand)
         {
            _border.height = 195;
            _box.visible = true;
            _arrow.scaleY = 1;
            _arrow.y = 5;
         }
         else
         {
            _border.height = 35;
            _box.visible = false;
            _arrow.scaleY = -1;
            _arrow.y = 17;
         }
      }
      
      private function __stageResizeHandler(param1:Event = null) : void
      {
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         this.x = (_loc2_ - 172) / 2;
         this.y = 0;
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:ButtonSkiner in _skinArr)
         {
            _loc1_.dispose();
            _loc1_.data = null;
         }
         _skinArr = null;
         removeEvent();
         ObjectUtils.disposeObject(_box);
         ObjectUtils.disposeObject(_arrow);
         super.dispose();
         _border = null;
         _title = null;
         _titleBg = null;
         _arrow = null;
         _box = null;
      }
   }
}

