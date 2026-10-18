package thessbox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.ThessBoxInfo;
   import thessbox.ui.ThessboxCapterUI;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ThessBoxTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ThessBoxCapterItem extends ThessboxCapterUI
   {
      
      private var _titleTxt:GradientText;
      
      private var _data:ThessBoxTempInfo;
      
      private var _firstItemList:Array = [];
      
      private var _preItemList:Array = [];
      
      private var _userInfo:ThessBoxInfo;
      
      private var _maxNum:int;
      
      public function ThessBoxCapterItem()
      {
         super();
         initData();
         initEvent();
      }
      
      private function initData() : void
      {
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.ChaptertitleTxt");
         addChild(_titleTxt);
         _chapter6.visible = false;
         _gotoFtBtn.visible = false;
         _rtBtn.visible = false;
         _chapt1.text = LanguageMgr.GetTranslation("thesebox.chapterTitle1");
         _chapt2.text = LanguageMgr.GetTranslation("thesebox.chapterTitle2");
      }
      
      public function set data(param1:ThessBoxTempInfo) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc5_:Array = null;
         var _loc3_:Array = null;
         _data = param1;
         if(_data)
         {
            _titleTxt.text = _data.ChaptersName + " ";
            _icon.icon = IconFactory.getCommonIconPath(_data.Icon);
            _loc6_ = 0;
            _loc4_ = 0;
            _loc5_ = GoodsManager.getGoodListByPramStr(_data.FirstPassAward);
            _loc4_ = int(_loc5_.length);
            _fristCapHbox.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = _loc5_[_loc6_];
               _loc2_ = ComponentFactory.Instance.creatCustomObject("thessbox.chapter.BaseItemView");
               _loc2_.data = _loc7_;
               _fristCapHbox.addChild(_loc2_);
               _firstItemList.push(_loc2_);
               _loc6_++;
            }
            _fristCapHbox.commitChanges();
            _fristPanel.invalidateViewport();
            _loc3_ = _data.PassDropAward.split(",");
            _loc4_ = int(_loc3_.length);
            _ch2Hbox.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = int(_loc3_[_loc6_]);
               _loc7_.count = 0;
               _loc7_.showHasGet = true;
               _loc2_ = ComponentFactory.Instance.creatCustomObject("thessbox.glv.BaseItemView");
               _loc2_.data = _loc7_;
               _ch2Hbox.addChild(_loc2_);
               _preItemList.push(_loc2_);
               _loc6_++;
            }
            _ch2Hbox.commitChanges();
            _prePanel.invalidateViewport();
         }
      }
      
      public function updateView(param1:ThessBoxInfo, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         _userInfo = param1;
         _maxNum = param2;
         _chapter6.visible = false;
         if(_data.Id <= param1.passChapter)
         {
            _chapter6.visible = true;
            if(param1.firstRewardList.indexOf("" + _data.Id) != -1)
            {
               _gotoFtBtn.visible = true;
               _rtBtn.visible = false;
               _loc5_ = 0;
               _loc4_ = int(_firstItemList.length);
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc3_ = _firstItemList[_loc5_];
                  _loc6_ = _loc3_.data;
                  _loc6_.showHasGet = true;
                  _loc3_.data = _loc6_;
                  _loc5_++;
               }
            }
            else
            {
               _rtBtn.visible = true;
               _gotoFtBtn.visible = false;
            }
         }
         else if(_data.Id == param1.passChapter + 1)
         {
            _gotoFtBtn.visible = true;
            _rtBtn.visible = false;
         }
         else
         {
            _gotoFtBtn.visible = false;
            _rtBtn.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         _gotoFtBtn.addEventListener("click",gotoFightHandler);
         _rtBtn.addEventListener("click",rewardHandler);
      }
      
      private function removeEvent() : void
      {
         _gotoFtBtn.removeEventListener("click",gotoFightHandler);
         _rtBtn.removeEventListener("click",rewardHandler);
      }
      
      private function rewardHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.opThessbox(2,_data.Id);
      }
      
      private function gotoFightHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _maxNum - _userInfo.count;
         _loc2_ = int(_loc2_ < 0 ? 0 : _loc2_);
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("thesebox.chapterNoFight"));
            return;
         }
         TheseussoulManager.Instance.opThessbox(1,_data.Id);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         LogicUtils.disposeDisplayCollection(_firstItemList);
         _firstItemList = null;
         LogicUtils.disposeDisplayCollection(_preItemList);
         _preItemList = null;
         _userInfo = null;
         _data = null;
      }
   }
}

