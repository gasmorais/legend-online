package gloryroad.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GloryroadManager;
   import mvc.module.gloryroad.GloryRoadModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   
   public class GloryRoadDifficultyFrame extends GloryRoadView
   {
      
      private var _grids:Vector.<Image>;
      
      private var _btns:Vector.<IconButton>;
      
      private var _txts:Array;
      
      private var _index:int;
      
      private var _model:GloryRoadModel;
      
      public function GloryRoadDifficultyFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         var _loc4_:FilterFrameText = null;
         var _loc6_:FilterFrameText = null;
         var _loc2_:FilterFrameText = null;
         var _loc1_:FilterFrameText = null;
         var _loc5_:int = 0;
         titleText = LanguageMgr.GetTranslation("GloryRoadDifficultyFrame.initView.title");
         _grids = new Vector.<Image>(3);
         _btns = new Vector.<IconButton>(3);
         _txts = new Array(3);
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _grids[_loc5_] = addCreatComponentByStylename("gloryroad.difficultyGridImg" + _loc5_);
            _grids[_loc5_].x = _loc3_;
            _loc3_ += _grids[_loc5_].width;
            _btns[_loc5_] = addCreatComponentByStylename("gloryroad.btnSelect");
            _btns[_loc5_].name = "selectBtn_" + _loc5_;
            _grids[_loc5_].addChild(_btns[_loc5_]);
            _loc1_ = creatComponentByStylename("gloryroad.difficultyBaseAtt");
            _grids[_loc5_].addChild(_loc1_);
            _loc4_ = creatComponentByStylename("gloryroad.difficultySocreTxt");
            _grids[_loc5_].addChild(_loc4_);
            _loc6_ = creatComponentByStylename("gloryroad.difficultyGloryTxt");
            _grids[_loc5_].addChild(_loc6_);
            _loc2_ = creatComponentByStylename("gloryroad.difficultyStarTxt");
            _grids[_loc5_].addChild(_loc2_);
            _txts[_loc5_] = [_loc1_,_loc4_,_loc6_,_loc2_];
            _loc5_++;
         }
         __refreshView(null);
      }
      
      override protected function initEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _btns.length)
         {
            addEvent(_btns[_loc1_],"click",__btnClickHanlder);
            _loc1_++;
         }
         addEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         super.initEvent();
      }
      
      override protected function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _btns.length)
         {
            deleteEvent(_btns[_loc1_],"click",__btnClickHanlder);
            _loc1_++;
         }
         deleteEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         super.removeEvent();
      }
      
      private function __btnClickHanlder(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _index = int(param1.target.name.split("_")[1]) + 1;
         if(GloryroadManager.instance.model.layer == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("GloryRoadDifficultyFrame.btnClickHanlder.alert");
            LogicUtils.alert(_loc2_,"SIMPLE_ALERT",suerHandler);
         }
         else
         {
            GloryroadManager.instance.fight(_index);
         }
      }
      
      private function suerHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         GloryroadManager.instance.fight(_index);
      }
      
      public function __refreshView(param1:Event) : void
      {
         var _loc5_:Array = null;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:FilterFrameText = null;
         var _loc4_:Array = model.getDiffectyData();
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc3_ = _txts[_loc6_];
            _loc2_ = _loc3_[0];
            _loc2_.text = getLanuage("GloryRoadDifficultyFrame.refreshView.txt1") + _loc5_[0] * 100 + "%";
            _loc2_ = _loc3_[1];
            _loc2_.text = getLanuage("GloryRoadDifficultyFrame.refreshView.txt2") + _loc5_[1];
            _loc2_ = _loc3_[2];
            _loc2_.text = getLanuage("GloryRoadDifficultyFrame.refreshView.txt3") + _loc5_[2];
            _loc2_ = _loc3_[3];
            _loc2_.text = getLanuage("GloryRoadDifficultyFrame.refreshView.txt4") + _loc5_[3];
            _loc6_++;
         }
      }
      
      private function get model() : GloryRoadModel
      {
         return _model || (_model = GloryroadManager.instance.model);
      }
      
      public function show() : void
      {
         closeButton.x = 505;
         closeButton.y = -10;
         _title.y = 0;
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_grids);
         _grids = null;
         LogicUtils.disposeDisplayCollection(_btns);
         _btns = null;
         LogicUtils.disposeDisplayCollection(_txts);
         _txts = null;
         super.dispose();
      }
   }
}

