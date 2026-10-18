package consortia.view.fb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.guildfb.GuildFBModel;
   import mvc.module.guildfb.GuildFBRaceNode;
   import yishi.manager.FrameControllerManager;
   import yishi.view.base.NumberBitmap;
   
   public class GuildFBTopUIView extends Sprite
   {
      
      private var _raceIdx:NumberBitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _topJiliImage:Image;
      
      private var _raceSortBtn:BaseButton;
      
      private var _raceRewardBtn:BaseButton;
      
      private var _bit3:Bitmap;
      
      private var _toptimeTxt:FilterFrameText;
      
      private var _data:GuildFBRaceNode;
      
      public function GuildFBTopUIView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get data() : GuildFBRaceNode
      {
         return _data;
      }
      
      public function set data(param1:GuildFBRaceNode) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:RegExp = null;
         _data = param1;
         if(_data == null || _data.state == 0)
         {
            _raceIdx.visible = false;
            _toptimeTxt.text = "";
            _bit1.visible = false;
            _bit2.visible = false;
            _raceRewardBtn.visible = false;
            _raceSortBtn.visible = false;
         }
         else
         {
            _raceIdx.visible = true;
            _raceRewardBtn.visible = true;
            _raceSortBtn.visible = true;
            _loc4_ = _data.beginTime.substr(0,10);
            _loc2_ = _data.endTime.substr(0,10);
            _loc3_ = /-/g;
            _toptimeTxt.text = _loc4_.replace(_loc3_,".") + "-" + _loc2_.replace(_loc3_,".");
            _bit1.visible = _data.state == 2;
            _bit2.visible = _data.state == 1;
            _raceIdx.num = _data.seasonId;
         }
      }
      
      private function initView() : void
      {
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.guild.top.end");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.guild.top.racing");
         _topJiliImage = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.topJiliBtn");
         _raceSortBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.raceSortBtn");
         _raceRewardBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.raceRewardBtn");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.guild.top.back");
         _toptimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.toptimeTxt");
         _raceIdx = ComponentFactory.Instance.creatCustomObject("ui.guildfb.raceSIdx");
         _raceIdx.initParams("asset.guildfb.top.S","asset.guildfb.top.num",14,18,9,14,"0123456789",14,4);
         addChild(_bit3);
         addChild(_bit1);
         addChild(_bit2);
         addChild(_raceIdx);
         addChild(_topJiliImage);
         addChild(_raceSortBtn);
         addChild(_raceRewardBtn);
         addChild(_toptimeTxt);
         _topJiliImage.tipData = GuildFBModel.BUFF_IDS;
      }
      
      private function addEvent() : void
      {
         if(_raceRewardBtn)
         {
            _raceRewardBtn.addEventListener("click",__raceRewardBtnHandler);
         }
         if(_raceSortBtn)
         {
            _raceSortBtn.addEventListener("click",__raceSortBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_raceRewardBtn)
         {
            _raceRewardBtn.removeEventListener("click",__raceRewardBtnHandler);
         }
         if(_raceSortBtn)
         {
            _raceSortBtn.removeEventListener("click",__raceSortBtnHandler);
         }
      }
      
      private function __raceRewardBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("guildfb",4);
      }
      
      private function __raceSortBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("guildfb",3);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_topJiliImage);
         _topJiliImage = null;
         ObjectUtils.disposeObject(_raceSortBtn);
         _raceSortBtn = null;
         ObjectUtils.disposeObject(_raceRewardBtn);
         _raceRewardBtn = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_toptimeTxt);
         _toptimeTxt = null;
         ObjectUtils.disposeObject(_raceIdx);
         _raceIdx = null;
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

