package alchemical
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.manager.AlchemicalManager;
   
   public class AlchemicalFrame extends Frame
   {
      
      private var border:Scale9CornerImage;
      
      private var exploitBtn:SelectedIconButton;
      
      private var makeBtn:SelectedIconButton;
      
      private var exploitView:AlchemicalExploitView;
      
      private var makeView:AlchemicalMakeView;
      
      private var btnGroup:SelectedButtonGroup;
      
      public function AlchemicalFrame()
      {
         super();
         initView();
         addEvent();
         AlchemicalManager.instance.sendAlchemicalOpenRequest();
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("AlchemicalFrame.border");
         exploitBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalFrame.exploitBtn");
         makeBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalFrame.makeBtn");
         addToContent(border);
         addToContent(exploitBtn);
         addToContent(makeBtn);
         btnGroup = new SelectedButtonGroup();
         btnGroup.addSelectItem(exploitBtn);
         btnGroup.addSelectItem(makeBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         btnGroup.addEventListener("change",__selectedChangHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         btnGroup.removeEventListener("change",__selectedChangHandler);
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(btnGroup.selectIndex == 0)
         {
            ObjectUtils.disposeObject(makeView);
            makeView = null;
            if(!exploitView)
            {
               exploitView = ComponentFactory.Instance.creatCustomObject("AlchemicalFrame.exploitView");
            }
            addToContent(exploitView);
         }
         else if(btnGroup.selectIndex == 1)
         {
            ObjectUtils.disposeObject(exploitView);
            exploitView = null;
            if(!makeView)
            {
               makeView = ComponentFactory.Instance.creatCustomObject("AlchemicalFrame.makeView");
            }
            addToContent(makeView);
         }
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         titleText = LanguageMgr.GetTranslation("AlchemicalFrame.titleText.text");
         if(param1 && param1.frameData)
         {
            model.selectFormulaInfo = param1.frameData.formulaInfo;
            btnGroup.selectIndex = param1.frameData.index;
         }
         else
         {
            btnGroup.selectIndex = 0;
         }
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         btnGroup = null;
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(exploitBtn);
         exploitBtn = null;
         ObjectUtils.disposeObject(makeBtn);
         makeBtn = null;
         ObjectUtils.disposeObject(exploitView);
         exploitView = null;
         ObjectUtils.disposeObject(makeView);
         makeView = null;
         super.dispose();
      }
   }
}

