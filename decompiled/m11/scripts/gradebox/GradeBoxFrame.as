package gradebox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.BoxManager;
   import managers.TaskTraceTipManager;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BoxTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.BaseBoxGoodsItem;
   
   public class GradeBoxFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _receiveBtn:SelectedIconButton;
      
      private var _list:SimpleTileList;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _levelContainer:Sprite;
      
      private var _levelNumData:BitmapData;
      
      public function GradeBoxFrame()
      {
         super();
         initView();
         initEvents();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("gradebox.Bg");
         _list = ComponentFactory.Instance.creatCustomObject("gradebox.goodsList",[4]);
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("gradebox.TitleImg");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("gradebox.GetRewardBtn");
         _levelNumData = ComponentFactory.Instance.creatBitmapData("asset.gradebox.NumStyle01");
         _levelContainer = new Sprite();
         _levelContainer.y = -24;
         addToContent(_back);
         addToContent(_receiveBtn);
         addToContent(_list);
         addToContent(_titleImg);
         addToContent(_levelContainer);
      }
      
      private function refreshView() : void
      {
         var _loc2_:BaseBoxGoodsItem = null;
         var _loc7_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = int(FrameControllerManager.instance.gradeBoxControler.data.templateInfo.NeedGrades);
         _list.beginChanges();
         var _loc1_:Vector.<BoxTemplateInfo> = BoxManager.instance.getGradeBoxGoodsByGrade(_loc4_);
         var _loc3_:int = int(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = int(_loc1_[_loc5_].TemplateId);
            _loc7_.count = int(_loc1_[_loc5_].Data);
            _loc2_ = new BaseBoxGoodsItem();
            _loc2_.data = _loc7_;
            _list.addChild(_loc2_);
            _loc5_++;
         }
         _loc6_ = int(_loc1_.length);
         while(_loc6_ < 6)
         {
            _loc2_ = new BaseBoxGoodsItem();
            _list.addChild(_loc2_);
            _loc6_++;
         }
         _list.commitChanges();
         NumberViewUtils.refreshValue(_loc4_,_levelContainer,_levelNumData,26,30,15,26,"0123456789");
         if(thane.grades >= _loc4_)
         {
            _receiveBtn.selected = true;
            _titleImg.setFrame(2);
            _levelContainer.x = 352;
            TaskTraceTipManager.showVipTipView = true;
            TaskTraceTipManager.showKingContractTipView = _loc4_ == 20;
         }
         else
         {
            _receiveBtn.selected = false;
            _titleImg.setFrame(1);
            _levelContainer.x = 132;
            TaskTraceTipManager.showVipTipView = false;
            TaskTraceTipManager.showKingContractTipView = false;
         }
         if(_loc4_ < 10)
         {
            _levelContainer.x += 7;
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         _receiveBtn.addEventListener("click",__receiveHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _receiveBtn.removeEventListener("click",__receiveHandler);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            if(_receiveBtn.selected)
            {
               SocketSendManager.instance.sendUseItem(FrameControllerManager.instance.gradeBoxControler.data.pos);
               _receiveBtn.selected = false;
               dispose();
            }
            else
            {
               dispose();
               FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL);
            }
         }
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SocketSendManager.instance.sendUseItem(FrameControllerManager.instance.gradeBoxControler.data.pos);
         _receiveBtn.selected = false;
         dispose();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_levelNumData);
         _levelNumData = null;
         ObjectUtils.disposeAllChildren(_levelContainer);
         _levelContainer = null;
         super.dispose();
      }
   }
}

