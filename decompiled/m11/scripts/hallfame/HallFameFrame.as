package hallfame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import hallfame.views.HallFameLeftButton;
   import hallfame.views.HallFameRightView;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class HallFameFrame extends Frame implements IManualSize
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _back:Bitmap;
      
      private var _leftVBox:VBox;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _rightView:HallFameRightView;
      
      private var _itemList:Vector.<HallFameLeftButton>;
      
      private var _helpBtn:BaseButton;
      
      public function HallFameFrame()
      {
         FunnyManager.instance.sendGetBag(1);
         super();
         initView();
         initData();
         initEvent();
         _selectedBtnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("hallfame.HallFameFrame.bg");
         _back = ComponentFactory.Instance.creatBitmap("asset.hallfame.back");
         _leftVBox = ComponentFactory.Instance.creatComponentByStylename("hallfame.leftVBox");
         _rightView = ComponentFactory.Instance.creatCustomObject("hallfame.rightView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("hallfame.HallFameFrame.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _selectedBtnGroup = new SelectedButtonGroup();
         addToContent(_bg);
         addToContent(_back);
         addToContent(_leftVBox);
         addToContent(_rightView);
         addToContent(_helpBtn);
      }
      
      private function initData() : void
      {
         var _loc3_:HallFameLeftButton = null;
         _itemList = new Vector.<HallFameLeftButton>();
         var _loc2_:int = 0;
         for each(var _loc1_:FunnyBagData in bagDataArr)
         {
            _loc2_++;
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("hallfame.leftSelectedBtn",[_loc2_]);
            _loc3_.data = _loc1_;
            _leftVBox.addChild(_loc3_);
            _itemList.push(_loc3_);
            _selectedBtnGroup.addSelectItem(_loc3_);
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         var _loc2_:HallFameLeftButton = _selectedBtnGroup.getSelectedItem() as HallFameLeftButton;
         if(!_loc2_)
         {
            return;
         }
         FunnyManager.instance.selectedId = _loc2_.data.id;
         _rightView.data = _loc2_.data;
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         var _loc3_:int = 0;
         for each(var _loc2_:FunnyBagData in bagDataArr)
         {
            _itemList[_loc3_].data = _loc2_;
            _loc3_++;
         }
         __selectedHandler(null);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectedBtnGroup.addEventListener("change",__selectedHandler);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selectedBtnGroup.removeEventListener("change",__selectedHandler);
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("hallfame.helpFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get bagDataArr() : Vector.<FunnyBagData>
      {
         return FunnyManager.instance.model.hallFameDataArr;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("hallfame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,660,493);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_leftVBox);
         _leftVBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

