package remainsexplore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import yishi.datas.templates.RemainsExploreActivityInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.RemainsExploreManager;
   import yishi.view.base.ProgressCommon;
   
   public class RemainsExploreActivityItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      private var _bar:ProgressCommon;
      
      private var _receiveBtn:IconButton;
      
      private var _index:int = 1;
      
      private var _data:RemainsExploreActivityInfo;
      
      public function RemainsExploreActivityItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityItem.bg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityItem.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityItem.txt");
         _bar = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityItem.bar");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityItem.receiveBtn");
         addChild(_bg);
         addChild(_icon);
         addChild(_txt);
         addChild(_bar);
         addChild(_receiveBtn);
      }
      
      private function addEvent() : void
      {
         _receiveBtn.addEventListener("click",__receiveBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _receiveBtn.removeEventListener("click",__receiveBtnClickHandler);
      }
      
      private function __receiveBtnClickHandler(param1:MouseEvent) : void
      {
         RemainsExploreManager.instance.sendReceive(_data.TemplateId);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _bg.setFrame(_index);
         _icon.setFrame(_index);
      }
      
      public function set data(param1:RemainsExploreActivityInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _txt.text = _data.Description;
         _bar.value = _data.currentCount / int(_data.Param1);
         _bar.text = _data.currentCount + "/" + _data.Param1;
         switch(int(_data.completeState))
         {
            case 0:
               this.filters = [];
               _receiveBtn.visible = true;
               _receiveBtn.enable = false;
               break;
            case 1:
               this.filters = [];
               _receiveBtn.visible = true;
               _receiveBtn.enable = true;
               break;
            case 2:
               this.filters = [UIFilter.getGrayFilter()];
               _receiveBtn.visible = false;
               _receiveBtn.enable = false;
         }
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

