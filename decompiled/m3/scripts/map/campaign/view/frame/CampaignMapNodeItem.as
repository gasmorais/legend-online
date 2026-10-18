package map.campaign.view.frame
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import map.campaign.CampaignManager;
   import map.internals.data.CampaignNode;
   
   public class CampaignMapNodeItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _selected:Boolean;
      
      private var _selectedBg:Scale9CornerImage;
      
      private var _npcName:FilterFrameText;
      
      private var _npcType:GradientText;
      
      private var _line:ScaleBitmapImage;
      
      private var _data:CampaignNode;
      
      public function CampaignMapNodeItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,150,28);
      }
      
      private function initView() : void
      {
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.MapNodeItemBg");
         _npcName = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.MapNodeItem.NameTxt");
         _npcType = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.MapNodeItem.TypeTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.MapNodeItem.Line");
         addChild(_selectedBg);
         addChild(_npcName);
         addChild(_npcType);
         addChild(_line);
         _selectedBg.visible = false;
         createHitArea();
      }
      
      private function createHitArea() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,170,21);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onClickHandler);
         addEventListener("rollOver",__onRollOverHandler);
         addEventListener("rollOut",__onRollOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
         removeEventListener("rollOver",__onRollOverHandler);
         removeEventListener("rollOut",__onRollOutHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(CampaignManager.instance.controller)
         {
            SoundManager.instance.play("022");
            CampaignManager.instance.mapModel.selectNode = _data;
            CampaignManager.instance.controller.moveArmyByPos(_data.curPosX * 20,_data.curPosY * 20,true);
         }
      }
      
      private function __onRollOverHandler(param1:MouseEvent) : void
      {
         _selectedBg.visible = true;
      }
      
      private function __onRollOutHandler(param1:MouseEvent) : void
      {
         _selectedBg.visible = false;
      }
      
      public function set data(param1:CampaignNode) : void
      {
         _data = param1;
         if(_data)
         {
            buttonMode = true;
            addEvent();
            _npcName.text = _data.info.names;
            _npcType.text = _data.param5;
         }
         else
         {
            buttonMode = false;
            removeEvent();
         }
      }
      
      public function get data() : CampaignNode
      {
         return _data;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_npcName);
         _npcName = null;
         ObjectUtils.disposeObject(_npcType);
         _npcType = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

