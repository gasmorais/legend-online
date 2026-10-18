package map.campaign.mediator.fantasymatrix
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import map.campaign.data.FantasyMatrixNodeInfo;
   import yishi.datas.ai.NpcAiInfo;
   import yishi.filter.SimpleBuildingFilter;
   
   public class FantasyMatrixWarNodeView extends Component
   {
      
      private var lightMc:MovieClip;
      
      private var npcView:FantasyMatrixNpcAvatarView;
      
      private var skillMc:MovieClip;
      
      private var boxImage:Bitmap;
      
      private var _data:FantasyMatrixNodeInfo;
      
      private var pawnTempId:int = -1;
      
      public function FantasyMatrixWarNodeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         lightMc = ComponentFactory.Instance.creatCustomObject("FantasyMatrixWarNodeView.lightMc");
         boxImage = ComponentFactory.Instance.creatBitmap("asset.FantasyMatrixWarNodeView.boxImage");
         npcView = new FantasyMatrixNpcAvatarView();
         addChild(lightMc);
         addChild(npcView);
         addChild(boxImage);
         boxImage.visible = false;
         lightMc.visible = false;
         lightMc.gotoAndStop(1);
         this.mouseEnabled = lightMc.mouseEnabled = false;
      }
      
      public function get data() : FantasyMatrixNodeInfo
      {
         return _data;
      }
      
      public function set data(param1:FantasyMatrixNodeInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:NpcAiInfo = null;
         ObjectUtils.disposeViolentMc(skillMc);
         skillMc = null;
         lightMc.visible = false;
         lightMc.gotoAndStop(1);
         if(!data)
         {
            return;
         }
         if(pawnTempId != data.pawnTempId)
         {
            _loc1_ = new NpcAiInfo();
            _loc1_.isLiving = true;
            _loc1_.moveState = 3;
            _loc1_.centerPoint = new Point(0,0);
            npcView.filter = new SimpleBuildingFilter();
            npcView.info = _loc1_;
            npcView.nodeInfo = data;
            pawnTempId = data.pawnTempId;
         }
         npcView.updateNpcView();
         boxImage.visible = data.showBox;
         if(data.showSkillId != 0)
         {
            skillMc = ComponentFactory.Instance.creatCustomObject("FantasyMatrixWarNodeView.skillMc" + data.showSkillId);
            addChild(skillMc);
            skillMc.mouseEnabled = false;
         }
         lightMc.visible = data.state == 2 ? true : false;
         if(lightMc.visible)
         {
            lightMc.gotoAndPlay(1);
         }
      }
      
      public function execute() : void
      {
         if(npcView && data && data.state != 0)
         {
            npcView.execute();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(npcView);
         npcView = null;
         ObjectUtils.disposeObject(boxImage);
         boxImage = null;
         ObjectUtils.disposeViolentMc(skillMc);
         skillMc = null;
         ObjectUtils.disposeViolentMc(lightMc);
         lightMc = null;
         super.dispose();
      }
   }
}

