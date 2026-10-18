package monsterexplore.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import yishi.datas.templates.MonsterExploreTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.MonsterExploreManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   
   public class MonsterExploreChapterNodeItem extends Component
   {
      
      private var _ballImage:ScaleFrameImage;
      
      private var _nodeCon:Component;
      
      private var _numBit:BitmapData;
      
      private var _data:MonsterExploreTempInfo;
      
      public function MonsterExploreChapterNodeItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _ballImage = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreChapterNodeItem.ballImage");
         _nodeCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreChapterNodeItem.nodeCon");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.MonsterExploreChapterNodeItem.numBit");
         addChild(_ballImage);
         addChild(_nodeCon);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("EXPLORE_CLICK_NODE",this);
      }
      
      public function get data() : MonsterExploreTempInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterExploreTempInfo) : void
      {
         _data = param1;
         if(data)
         {
            this.visible = true;
            if(exploreModel.curChapterId == data.ChapterId && exploreModel.curNodeId == data.NodeId)
            {
               _ballImage.setFrame(2);
            }
            else
            {
               _ballImage.setFrame(1);
            }
            NumberViewUtils.refreshValue(data.NodeId,_nodeCon,_numBit,16,19,12,16,"0123456789");
            _nodeCon.x = data.NodeId < 10 ? 17 : 11;
            if(data.ChapterId > exploreModel.maxChapterId || data.ChapterId == exploreModel.maxChapterId && data.NodeId > exploreModel.maxNodeId + 1)
            {
               this.filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               this.filters = [];
            }
         }
         else
         {
            this.visible = false;
         }
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_ballImage);
         _ballImage = null;
         ObjectUtils.disposeObject(_nodeCon);
         _nodeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         super.dispose();
      }
   }
}

