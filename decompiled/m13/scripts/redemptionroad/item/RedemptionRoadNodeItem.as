package redemptionroad.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.RedemptionRoadManager;
   import mvc.module.redemptionroad.RedemptionRoadModel;
   import mvc.module.redemptionroad.RedemptionRoadNodeInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class RedemptionRoadNodeItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _bossIcon:BaseIconView;
      
      private var _topBack:Bitmap;
      
      private var _selectBg:Bitmap;
      
      private var _stateImage:ScaleFrameImage;
      
      private var _nodeInfo:RedemptionRoadNodeInfo;
      
      private var pos:int;
      
      private var maxCount:int;
      
      public function RedemptionRoadNodeItem(param1:int, param2:int)
      {
         super();
         pos = param1;
         maxCount = param2;
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.RedemptionRoadNodeItem.back");
         _topBack = ComponentFactory.Instance.creatBitmap("asset.RedemptionRoadNodeItem.topBack");
         _bossIcon = ComponentFactory.Instance.creatCustomObject("RedemptionRoadNodeItem.bossIcon");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.RedemptionRoadNodeItem.selectBg");
         _stateImage = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadNodeItem.stateImage");
         addChild(_back);
         addChild(_bossIcon);
         addChild(_topBack);
         addChild(_selectBg);
         addChild(_stateImage);
         _selectBg.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         model.selectPos = pos;
      }
      
      public function get nodeInfo() : RedemptionRoadNodeInfo
      {
         return _nodeInfo;
      }
      
      public function set nodeInfo(param1:RedemptionRoadNodeInfo) : void
      {
         _nodeInfo = param1;
         if(!nodeInfo)
         {
            return;
         }
         if(nodeInfo.getBossTemp())
         {
            _bossIcon.icon = IconFactory.getHeroicon(nodeInfo.getBossTemp().TemplateId);
         }
         else if(nodeInfo.getNpcTemp())
         {
            _bossIcon.icon = IconFactory.getSoldierIconByIcon(nodeInfo.getNpcTemp().Icon);
         }
         else
         {
            _bossIcon.icon = null;
         }
         if(nodeInfo.layer == model.curLayer)
         {
            addEvent();
            this.filters = [];
            this.buttonMode = true;
            _stateImage.visible = false;
         }
         else
         {
            removeEvent();
            this.buttonMode = false;
            if(nodeInfo.layer > model.curLayer)
            {
               this.filters = [UIFilter.getGrayFilter()];
               _stateImage.visible = false;
            }
            else
            {
               this.filters = [];
               _stateImage.visible = true;
            }
            if(model.roadPaths && model.roadPaths.indexOf(nodeInfo.id) != -1)
            {
               _stateImage.setFrame(1);
            }
            else
            {
               _stateImage.setFrame(2);
            }
         }
      }
      
      public function refreshSelect() : void
      {
         _selectBg.visible = nodeInfo.layer == model.curLayer && pos == model.selectPos;
      }
      
      private function get model() : RedemptionRoadModel
      {
         return RedemptionRoadManager.instance.model;
      }
      
      public function get weight() : Number
      {
         if(maxCount == 1)
         {
            return 10;
         }
         if(maxCount == 2)
         {
            return pos * 10 + 5;
         }
         if(maxCount >= 3)
         {
            return pos * 10;
         }
         return -1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_topBack);
         _topBack = null;
         ObjectUtils.disposeObject(_bossIcon);
         _bossIcon = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_stateImage);
         _stateImage = null;
         super.dispose();
      }
   }
}

