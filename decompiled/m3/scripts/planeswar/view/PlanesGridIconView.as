package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesGridInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.datas.templates.PlanesTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class PlanesGridIconView extends Component
   {
      
      private static const WIDTH:int = 100;
      
      private static const HEIGHT:int = 100;
      
      private var _gridInfo:PlanesGridInfo;
      
      private var _eventIcon:BaseIconView;
      
      private var nameText:FilterFrameText;
      
      private var occupyText:FilterFrameText;
      
      private var _sprite:Component;
      
      private var mapTempInfo:PlanesTemplateInfo;
      
      private var eventTempInfo:PlanesEventsTemplateInfo;
      
      private var layerTempInfo:PlanesLayerTemplateInfo;
      
      private var eventId:int = -1;
      
      private var opened:Boolean = false;
      
      private var occupied:Boolean = false;
      
      private var fontBase:Boolean = false;
      
      private var occupy_name:String = "";
      
      private var mouseIsMove:Boolean;
      
      public function PlanesGridIconView()
      {
         super();
         initView();
         addEvent();
         layerTempInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(model.planesWarInfo.layerTempId);
      }
      
      private function initView() : void
      {
         _eventIcon = ComponentFactory.Instance.creatCustomObject("planesGridIconView.GridIconView",[__iconLoadComplete]);
         nameText = ComponentFactory.Instance.creatComponentByStylename("planesGridIconView.nameText");
         occupyText = ComponentFactory.Instance.creatComponentByStylename("planesGridIconView.occupyText");
         _sprite = new Component();
         addChild(_eventIcon);
         addChild(_sprite);
         _eventIcon.mouseChildren = _eventIcon.mouseEnabled = false;
         this.mouseEnabled = false;
         drawHitArea(0);
      }
      
      private function drawHitArea(param1:Number = 0) : void
      {
         _sprite.graphics.clear();
         _sprite.graphics.beginFill(65280,param1);
         _sprite.graphics.lineStyle(0,0,0);
         _sprite.graphics.drawRect(0,0,100,100);
         _sprite.tipStyle = "yishi.view.tips.PlanesEventTips";
         _sprite.isFollowMouse = false;
         _sprite.tipDirctions = "7,5,4,6";
         _sprite.tipGapH = 80;
         _sprite.tipGapV = 10;
      }
      
      private function addEvent() : void
      {
         _sprite.addEventListener("mouseDown",onMouseDown);
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         _sprite.addEventListener("mouseMove",onMouseMove);
         _sprite.addEventListener("mouseUp",onMouseUp);
         mouseIsMove = false;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         mouseIsMove = true;
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         _sprite.removeEventListener("mouseMove",onMouseMove);
         _sprite.removeEventListener("mouseUp",onMouseUp);
         if(mouseIsMove)
         {
            return;
         }
         __onclickHandler();
      }
      
      private function __onclickHandler() : void
      {
         FrameControllerManager.instance.planesWarControler.moveGridByXY(_gridInfo.x,_gridInfo.y);
      }
      
      public function set data(param1:PlanesGridInfo) : void
      {
         _gridInfo = param1;
         if(eventId == param1.eventId && opened == _gridInfo.opened && occupied == _gridInfo.occupied && fontBase == _gridInfo.frontBase && occupy_name == _gridInfo.occupyName)
         {
            return;
         }
         eventId = _gridInfo.eventId;
         opened = _gridInfo.opened;
         occupied = _gridInfo.occupied;
         fontBase = _gridInfo.frontBase;
         occupy_name = _gridInfo.occupyName;
         refreshView();
      }
      
      public function get gridInfo() : PlanesGridInfo
      {
         return _gridInfo;
      }
      
      public function refreshView() : void
      {
         if(_eventIcon != null && Boolean(this.contains(_eventIcon)))
         {
            removeChild(_eventIcon);
         }
         if(_gridInfo.eventId != 0)
         {
            eventTempInfo = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(_gridInfo.eventId);
            _eventIcon.icon = PathManager.getPlanesIconUrlByTempId(eventTempInfo.EventTempId);
            addChild(_eventIcon);
         }
      }
      
      private function __iconLoadComplete(param1:BaseIconView = null) : void
      {
         var _loc2_:Object = null;
         if(eventTempInfo)
         {
            _loc2_ = {};
            _loc2_.layerTemp = layerTempInfo;
            _loc2_.eventTemp = eventTempInfo;
            _sprite.tipData = _loc2_;
            if(eventTempInfo.EventType == 12)
            {
               if(_gridInfo.occupied)
               {
                  addChild(nameText);
                  nameText.text = _gridInfo.occupyName;
               }
            }
         }
         if(_gridInfo.frontBase == true)
         {
            param1.scaleX = param1.scaleY = 0.8;
            addChild(nameText);
            nameText.text = _gridInfo.occupyName;
         }
         if(nameText && nameText.parent)
         {
            if(nameText.text == PlayerManager.instance.currentPlayerModel.playerInfo.nickName)
            {
               nameText.setFrame(1);
            }
            else
            {
               nameText.setFrame(2);
            }
            nameText.x = (100 - nameText.width) / 2;
            nameText.y = -15;
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      public function get eventIcon() : BaseIconView
      {
         return _eventIcon;
      }
      
      public function removeEventIcon(param1:BaseIconView) : void
      {
         if(param1)
         {
            if(param1.content)
            {
               if(param1.content is MovieClip)
               {
                  (param1.content as MovieClip).stop();
               }
            }
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
            if(nameText.parent)
            {
               nameText.parent.removeChild(nameText);
            }
         }
      }
      
      public function addEventIcon(param1:BaseIconView) : void
      {
         if(param1)
         {
            if(param1.content)
            {
               if(param1.content is MovieClip)
               {
                  (param1.content as MovieClip).play();
               }
            }
            if(_gridInfo.eventId != 0)
            {
               this.addChild(param1);
            }
            if(_gridInfo.occupyName != null)
            {
               this.addChild(nameText);
               if(nameText.text == PlayerManager.instance.currentPlayerModel.playerInfo.nickName)
               {
                  nameText.setFrame(1);
               }
               else
               {
                  nameText.setFrame(2);
               }
            }
         }
         if(!param1.parent)
         {
            _sprite.tipData = null;
         }
      }
      
      override public function dispose() : void
      {
         this.removeEventListener("mouseDown",onMouseDown);
         if(eventIcon)
         {
            removeEventIcon(eventIcon);
            ObjectUtils.disposeObject(eventIcon);
            _eventIcon = null;
         }
         if(_sprite)
         {
            ObjectUtils.disposeObject(_sprite);
         }
         _sprite = null;
         if(nameText)
         {
            ObjectUtils.disposeObject(nameText);
         }
         nameText = null;
         if(occupyText)
         {
            ObjectUtils.disposeObject(occupyText);
         }
         occupyText = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

