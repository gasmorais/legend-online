package armyII.viewII.tattoo
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.tattoo.TattooHoleInfoII;
   import mvc.module.tattoo.TattooModel;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class TattooNewHoleView extends Component implements ISelectable, IManualSize
   {
      
      private var border:Bitmap;
      
      private var propertyImage:ScaleFrameImage;
      
      private var holeMc:MovieClip;
      
      private var starContiner:Component;
      
      private var _selected:Boolean;
      
      private var _data:TattooHoleInfoII;
      
      private var _preState:Boolean = true;
      
      private var tipArea:Component;
      
      private var starPosArr:Array = [[59,16],[75,27],[83,47],[77,67],[60,80],[37,81],[20,67],[14,47],[22,27],[37,16]];
      
      public function TattooNewHoleView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,113,113);
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatBitmap("asset.TattooNewHoleView.border");
         propertyImage = ComponentFactory.Instance.creatComponentByStylename("TattooNewHoleView.propertyImage");
         holeMc = ComponentFactory.Instance.creatCustomObject("TattooNewHoleView.holeMc");
         starContiner = ComponentFactory.Instance.creatComponentByStylename("TattooNewHoleView.starContiner");
         tipArea = ComponentFactory.Instance.creatComponentByStylename("TattooNewHoleView.tipArea");
         tipArea.graphics.clear();
         tipArea.graphics.beginFill(0,0);
         tipArea.graphics.drawCircle(55,55,48);
         addChild(holeMc);
         holeMc.gotoAndStop(1);
         addChild(propertyImage);
         propertyImage.setFrame(5);
         addChild(starContiner);
         addChild(border);
         border.visible = false;
         border.x = -1;
         addChild(tipArea);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         addEventListener("mouseOver",__itemOverHandler);
         addEventListener("mouseOut",__itemOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         removeEventListener("mouseOver",__itemOverHandler);
         removeEventListener("mouseOut",__itemOutHandler);
      }
      
      private function __itemOverHandler(param1:MouseEvent) : void
      {
         if(!data || !data.enable || selected)
         {
            return;
         }
         border.visible = true;
      }
      
      private function __itemOutHandler(param1:MouseEvent) : void
      {
         if(!data || !data.enable || selected)
         {
            return;
         }
         border.visible = false;
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!data || !data.enable)
         {
            return;
         }
         model.selectedNewHoleInfo = data;
      }
      
      public function get data() : TattooHoleInfoII
      {
         return _data;
      }
      
      public function set data(param1:TattooHoleInfoII) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var curUpgrdeTemp:UpgradeTemplateInfo;
         var nextUpgrdeTemp:UpgradeTemplateInfo;
         var levelText:String;
         var addProperityLevelStr:String;
         var addProperityPrecentStr:String;
         ObjectUtils.disposeAllChildren(starContiner);
         tipArea.tipData = "";
         if(data)
         {
            if(data.property == -1)
            {
               propertyImage.setFrame(5);
            }
            else
            {
               propertyImage.setFrame(data.property + 1);
               curUpgrdeTemp = TempleteManager.instance.getTemplateByLevelAndType(data.level,119);
               nextUpgrdeTemp = TempleteManager.instance.getTemplateByLevelAndType(data.level + 1,119);
               levelText = LanguageMgr.GetTranslation("public.level2",data.level);
               if(!nextUpgrdeTemp)
               {
                  levelText = LanguageMgr.GetTranslation("public.level2","max");
               }
               addProperityLevelStr = "";
               addProperityPrecentStr = "";
               if(curUpgrdeTemp && curUpgrdeTemp.Data > 0)
               {
                  addProperityLevelStr = LanguageMgr.GetTranslation("TattooView.imprintBtn.ProperityLevel" + data.property,levelText) + "\n";
                  addProperityPrecentStr = LanguageMgr.GetTranslation("TattooView.imprintBtn.ProperityPrecent" + data.property,curUpgrdeTemp.Data);
               }
               tipArea.tipData = addProperityLevelStr + addProperityPrecentStr;
            }
            if(!_preState && Boolean(data.enable))
            {
               holeMc.gotoAndPlay(1);
               holeMc.addFrameScript(holeMc.totalFrames - 1,function():void
               {
                  holeMc.stop();
                  this.buttonMode = true;
               });
            }
            else if(data.enable)
            {
               this.buttonMode = true;
               holeMc.gotoAndStop(holeMc.totalFrames - 1);
               addStar();
            }
            _preState = data.enable;
         }
         else
         {
            this.buttonMode = false;
            holeMc.gotoAndStop(1);
            _preState = false;
         }
      }
      
      private function addStar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Bitmap = null;
         _loc1_ = 0;
         while(_loc1_ < data.level)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.TattooNewHoleView.starImage");
            starContiner.addChild(_loc2_);
            _loc2_.x = starPosArr[_loc1_][0];
            _loc2_.y = starPosArr[_loc1_][1];
            _loc1_++;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         border.visible = _selected;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      private function get model() : TattooModel
      {
         return FrameControllerManager.instance.tattooController.tattooModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(propertyImage);
         propertyImage = null;
         ObjectUtils.disposeViolentMc(holeMc);
         holeMc = null;
         ObjectUtils.disposeAllChildren(starContiner);
         ObjectUtils.disposeObject(starContiner);
         starContiner = null;
         ObjectUtils.disposeObject(tipArea);
         tipArea = null;
         super.dispose();
      }
   }
}

