package theseus.war
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusCCItem;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusWarStarChooseFrame extends Frame implements IManualSize
   {
      
      private var _hasChooseTxt:FilterFrameText;
      
      private var _materialViewList:SimpleTileList;
      
      private var _materialScroll:ScrollPanel;
      
      private var _materialData:Array;
      
      private var _materialList:Vector.<TheseusCCItem>;
      
      private var _column:int = 5;
      
      private var _hasChooseList:Array = [];
      
      private var _idx:int;
      
      private var _targetNum:int;
      
      private var _hasCount:int;
      
      private var _confirm:IconButton;
      
      public function TheseusWarStarChooseFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,450,395);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("theseus.war.xz");
         _hasChooseTxt = ComponentFactory.Instance.creatComponentByStylename("theseus.starChooseFrame.hasChooseTxt");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("theseus.starChooseFrame.confrimBtn");
         _materialViewList = ComponentFactory.Instance.creatCustomObject("theseus.BagII.materialViewList",[_column]);
         _materialScroll = ComponentFactory.Instance.creatComponentByStylename("theseus.starChooseFrame.materialScroll");
         _materialScroll.setView(_materialViewList);
         _materialList = new Vector.<TheseusCCItem>();
         addToContent(_materialScroll);
         addToContent(_confirm);
         addToContent(_hasChooseTxt);
      }
      
      private function refreshView(param1:Array) : void
      {
         var _loc2_:TheseusCCItem = null;
         var _loc11_:TheseusWarsoulItemInfo = null;
         var _loc6_:* = 0;
         var _loc9_:int = int(param1.length);
         var _loc10_:int = int(_materialList.length);
         var _loc5_:int = Math.max(_loc9_,_loc10_);
         var _loc3_:int = Math.ceil(_loc5_ / _column) * _column;
         _materialViewList.beginChanges();
         var _loc8_:Array = TheseussoulManager.Instance.warsoulModel.starParamList;
         var _loc4_:String = _loc8_[_idx];
         var _loc7_:Array = _loc4_.split(",");
         _hasCount = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(_loc6_ >= _loc10_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.theseus.cFrame.TheseusCCItem");
               _loc2_.addEventListener("click",itemClickHandler);
               _materialViewList.addChild(_loc2_);
               _materialList.push(_loc2_);
            }
            else
            {
               _loc2_ = _materialViewList[_loc6_];
            }
            if(_loc6_ >= _loc9_)
            {
               _loc2_.data = null;
            }
            else
            {
               _loc11_ = param1[_loc6_];
               _loc2_.data = _loc11_;
               if(_loc7_.indexOf("" + _loc11_.id) != -1)
               {
                  _loc2_.isChoose = true;
                  _hasCount = _hasCount + 1;
                  _hasChooseList.push(_loc11_.id);
               }
               else
               {
                  _loc2_.isChoose = false;
               }
            }
            _loc6_++;
         }
         _hasChooseTxt.text = LanguageMgr.GetTranslation("theseus.war.hasxz",_hasCount,_targetNum);
         _materialViewList.hSpace = 3;
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
         visible = true;
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TheseusCCItem = param1.currentTarget as TheseusCCItem;
         if(!_loc2_.data)
         {
            return;
         }
         if(_hasChooseList.length >= _targetNum && !_loc2_.isChoose)
         {
            if(_hasChooseList.indexOf(_loc2_.data.id) == -1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.chooseFull"));
               return;
            }
         }
         _loc2_.isChoose = !_loc2_.isChoose;
         if(_loc2_.isChoose)
         {
            _loc3_ = _hasChooseList.indexOf(_loc2_.data.id);
            if(_loc3_ == -1)
            {
               _hasChooseList.push(_loc2_.data.id);
               _hasCount = _hasCount + 1;
            }
         }
         else
         {
            _loc3_ = _hasChooseList.indexOf(_loc2_.data.id);
            if(_loc3_ != -1)
            {
               _hasChooseList.splice(_loc3_,1);
               _hasCount = _hasCount - 1;
            }
         }
         _hasChooseTxt.text = LanguageMgr.GetTranslation("theseus.war.hasxz",_hasCount,_targetNum);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirm.addEventListener("click",confrimClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirm.removeEventListener("click",confrimClickHandler);
         for each(var _loc1_:TheseusCCItem in _materialList)
         {
            _loc1_.removeEventListener("click",itemClickHandler);
         }
      }
      
      private function confrimClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc4_:Array = TheseussoulManager.Instance.warsoulModel.starParamList;
         if(_hasChooseList && _hasChooseList.length > 0)
         {
            _loc2_ = _hasChooseList.join(",");
            _loc4_[_idx] = _loc2_;
            _loc3_ = int(_hasChooseList.length);
         }
         else
         {
            _loc4_[_idx] = "";
         }
         NotificationManager.instance.sendNotification("Event.starChooseResult",[_idx,_loc3_]);
         dispose();
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
         for each(var _loc1_:TheseusCCItem in _materialList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _materialList = null;
         ObjectUtils.disposeObject(_materialViewList);
         _materialViewList = null;
         ObjectUtils.disposeObject(_materialScroll);
         _materialScroll = null;
         ObjectUtils.disposeObject(_confirm);
         _confirm = null;
         super.dispose();
         _hasChooseList = null;
      }
      
      public function show(param1:Array) : void
      {
         _idx = param1[0];
         _targetNum = param1[1];
         var _loc2_:Array = param1[2];
         refreshView(_loc2_);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

