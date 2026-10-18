package theseus
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import theseus.view.ThereussoulEquipViewLook;
   import theseus.view.TheseussoulyiPageViewLook;
   import theseus.view.TreasurePageViewLook;
   import theseus.war.view.TheseusWarEquipPageViewLook;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ThereusLookEquipFrame extends Frame
   {
      
      private var _equipBtn:SelectedIconButton;
      
      private var _yiBtn:SelectedIconButton;
      
      private var _treasureBtn:SelectedIconButton;
      
      private var _warBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      public var btnGroup:SelectedButtonGroup;
      
      private var _equipView:ThereussoulEquipViewLook;
      
      private var _yiView:TheseussoulyiPageViewLook;
      
      private var _treasureView:TreasurePageViewLook;
      
      private var _warView:TheseusWarEquipPageViewLook;
      
      private var _type:int = 0;
      
      public function ThereusLookEquipFrame(param1:int)
      {
         super();
         _type = param1;
         initView();
         initEvent();
         btnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.equipSbtn");
         _yiBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.yiSbtn");
         _treasureBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.treasureBtn");
         _warBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulBtn");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.selectBtnHbox");
         btnGroup = new SelectedButtonGroup();
         _equipView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.ThereussoulEquipViewLook");
         _yiView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TheseussoulyiPageViewLook");
         _treasureView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TreasurePageViewLook");
         _warView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TheseusWarEquipPageViewLook");
         addToContent(_equipView);
         addToContent(_yiView);
         addToContent(_treasureView);
         addToContent(_warView);
         addToContent(_btnHbox);
         _btnHbox.beginChanges();
         _btnHbox.addChild(_equipBtn);
         _btnHbox.addChild(_yiBtn);
         _btnHbox.addChild(_treasureBtn);
         if(VersionSwitch.WARSOUL)
         {
            _btnHbox.addChild(_warBtn);
         }
         _btnHbox.commitChanges();
         btnGroup.addSelectItem(_equipBtn);
         btnGroup.addSelectItem(_yiBtn);
         btnGroup.addSelectItem(_treasureBtn);
         if(VersionSwitch.WARSOUL)
         {
            btnGroup.addSelectItem(_warBtn);
         }
         _btnHbox.visible = _type == 0;
      }
      
      private function initEvent() : void
      {
         btnGroup.addEventListener("change",__tabChangeHandler);
      }
      
      private function removeEvent() : void
      {
         btnGroup.removeEventListener("change",__tabChangeHandler);
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         if(this.parent && _type == 0)
         {
            (this.parent.parent as TheseusOtherFrame).updateSelfFrame(btnGroup.selectIndex);
         }
         this.width = 405;
         switch(int(btnGroup.selectIndex))
         {
            case 0:
               _equipView.visible = true;
               _yiView.visible = false;
               _treasureView.visible = false;
               _warView.visible = false;
               break;
            case 1:
               _equipView.visible = false;
               _yiView.visible = true;
               _treasureView.visible = false;
               _warView.visible = false;
               break;
            case 2:
               _equipView.visible = false;
               _yiView.visible = false;
               _treasureView.visible = true;
               _warView.visible = false;
               this.width = 755;
               break;
            case 3:
               _equipView.visible = false;
               _yiView.visible = false;
               _treasureView.visible = false;
               _warView.visible = true;
         }
      }
      
      public function initData(param1:ThaneInfo) : void
      {
         _equipView.initData(param1);
         _yiView.initData(param1);
         _treasureView.initData(param1);
         _warView.initData(param1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_yiBtn);
         _yiBtn = null;
         ObjectUtils.disposeObject(_treasureBtn);
         _treasureBtn = null;
         ObjectUtils.disposeObject(_warBtn);
         _warBtn = null;
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         ObjectUtils.disposeObject(_yiView);
         _yiView = null;
         ObjectUtils.disposeObject(_treasureView);
         _treasureView = null;
         ObjectUtils.disposeObject(_warView);
         _warView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

