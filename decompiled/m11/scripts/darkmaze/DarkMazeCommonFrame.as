package darkmaze
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.darkmaze.DarkMazeBattleChildInfo;
   import mvc.module.darkmaze.DarkMazeModel;
   import mvc.module.darkmaze.DarkMazeNodeInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.DarkMazeEventTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class DarkMazeCommonFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _adjustFormationBtn:IconButton;
      
      private var _enterBattleBtn:IconButton;
      
      private var _hbox1:HBox;
      
      private var _hbox2:HBox;
      
      private var _nodeId:int;
      
      private var _nodeType:int;
      
      private var _darkMazeEventTemp:DarkMazeEventTemplateInfo;
      
      public function DarkMazeCommonFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("darkmazeCommonFrame.txt1");
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("darkmazeCommonFrame.txt2");
         _adjustFormationBtn = ComponentFactory.Instance.creatComponentByStylename("darkmazeCommonFrame.adjustFormationBtn");
         _enterBattleBtn = ComponentFactory.Instance.creatComponentByStylename("darkmazeCommonFrame.enterBattleBtn");
         _hbox1 = ComponentFactory.Instance.creatComponentByStylename("darkmazeCommonFrame.hbox1");
         _hbox2 = ComponentFactory.Instance.creatComponentByStylename("darkmazeCommonFrame.hbox2");
         addToContent(_txt1);
         addToContent(_txt2);
         addToContent(_adjustFormationBtn);
         addToContent(_enterBattleBtn);
         addToContent(_hbox1);
         addToContent(_hbox2);
         _hbox1.spacing = 40;
         _txt1.text = LanguageMgr.GetTranslation("darkmaze.darkMazeCommonFrame.txt1");
         _txt2.text = LanguageMgr.GetTranslation("darkmaze.darkMazeCommonFrame.txt2");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_txt2);
         _txt2 = null;
         ObjectUtils.disposeObject(_adjustFormationBtn);
         _adjustFormationBtn = null;
         ObjectUtils.disposeObject(_enterBattleBtn);
         _enterBattleBtn = null;
         ObjectUtils.disposeObject(_hbox1);
         _hbox1 = null;
         ObjectUtils.disposeObject(_hbox2);
         _hbox2 = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_adjustFormationBtn)
         {
            _adjustFormationBtn.addEventListener("click",__adjustBtnHandler);
         }
         if(_enterBattleBtn)
         {
            _enterBattleBtn.addEventListener("click",__enterBattleBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_adjustFormationBtn)
         {
            _adjustFormationBtn.removeEventListener("click",__adjustBtnHandler);
         }
         if(_enterBattleBtn)
         {
            _enterBattleBtn.removeEventListener("click",__enterBattleBtnHandler);
         }
      }
      
      private function __adjustBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("darkmaze",8);
         dispose();
      }
      
      private function __enterBattleBtnHandler(param1:MouseEvent) : void
      {
         if(_nodeType == 3 || _nodeId == 2 || _nodeId == model.targetNodeId)
         {
            DarkMazeManager.instance.darkMazeOperation(2,_nodeId);
         }
         else if(_nodeType == 1 || _nodeType == 2)
         {
            if(model.battleChildIdList.length == 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.notHasBattleChild"));
               return;
            }
            model.moveToTargetNode(_nodeId,_nodeType);
         }
         else
         {
            model.moveToTargetNode(_nodeId,_nodeType);
         }
         dispose();
      }
      
      private function initData() : void
      {
         var _loc5_:int = 0;
         var _loc1_:DarkMazeCommonItemView = null;
         var _loc7_:DarkMazeBattleChildInfo = null;
         var _loc2_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         _hbox1.disposeAllChildren();
         var _loc6_:Array = model.childList;
         var _loc4_:int = int(_loc6_.length);
         var _loc9_:Array = model.battleChildIdList;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_ = new DarkMazeCommonItemView();
            _loc7_ = _loc6_[_loc5_] as DarkMazeBattleChildInfo;
            if(_loc7_ && _loc9_.indexOf(_loc7_.childId) >= 0)
            {
               _loc1_.currentHp = _loc7_.currentHp;
               _loc1_.totalHp = _loc7_.totalHp;
               _loc1_.data = _loc7_;
               _hbox1.addChild(_loc1_);
            }
            _loc5_++;
         }
         _hbox2.disposeAllChildren();
         if(_darkMazeEventTemp && !StringHelper.isNullOrEmpty(_darkMazeEventTemp.Reward))
         {
            _loc2_ = _darkMazeEventTemp.Reward.split("|");
            if(_loc2_)
            {
               _loc4_ = int(_loc2_.length);
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc3_ = ComponentFactory.Instance.creatCustomObject("darkMazeCommonItemView.baseItem");
                  _loc8_ = new GoodsInfo();
                  _loc8_.templateId = _loc2_[_loc5_].split(",")[0];
                  _loc8_.count = _loc2_[_loc5_].split(",")[1];
                  _loc3_.data = _loc8_;
                  _hbox2.addChild(_loc3_);
                  _loc5_++;
               }
            }
         }
      }
      
      private function getChildData() : Array
      {
         var _loc1_:DarkMazeBattleChildInfo = null;
         var _loc3_:int = 0;
         var _loc4_:Array = model.childList;
         var _loc2_:int = int(_loc4_.length);
         var _loc6_:Array = [];
         var _loc5_:Array = model.battleChildIdList;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc4_[_loc3_] as DarkMazeBattleChildInfo;
            if(_loc1_ && _loc5_.indexOf(_loc1_.childId) >= 0)
            {
               _loc6_.push(_loc1_);
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         var _loc2_:DarkMazeNodeInfo = null;
         if(param1 && param1.frameData)
         {
            _loc2_ = param1.frameData as DarkMazeNodeInfo;
            if(_loc2_)
            {
               _nodeId = _loc2_.nodeId;
               _darkMazeEventTemp = _loc2_.eventTemp;
               _nodeType = _loc2_.eventTemp.EventType;
               _enterBattleBtn.enable = _loc2_.isLight;
            }
         }
         _bg = ComponentFactory.Instance.creatComponentByStylename("darkmazeCommonFrame.bg" + _nodeType);
         addChildAt(_bg,0);
         initData();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : DarkMazeModel
      {
         return DarkMazeManager.instance.model;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
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
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

