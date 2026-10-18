package christmas.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import mvc.module.christmas.ChristmasTaskInfo;
   import yishi.datas.templates.ChristmasAchievementsTempInfo;
   import yishi.manager.ChristmasManager;
   
   public class ChristmasCjItem extends Sprite
   {
      
      protected var _bar:Bitmap;
      
      protected var _scorebg:Bitmap;
      
      protected var _cjGetBtn:IconButton;
      
      protected var _cjDesTxt:FilterFrameText;
      
      protected var _cjTitle:FilterFrameText;
      
      protected var _cjScore:FilterFrameText;
      
      private var _taskList:Array;
      
      private var _temp:ChristmasAchievementsTempInfo;
      
      private var _cjGetBg:Bitmap;
      
      private var _isDie:Boolean = false;
      
      public function ChristmasCjItem()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bar = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.bar");
         _scorebg = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.scorebg");
         _cjGetBtn = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjGetBtn");
         _cjDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjDesTxt");
         _cjTitle = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjTitle");
         _cjScore = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjScore");
         _cjGetBg = ComponentFactory.Instance.creatBitmap("asset.Christmas.hirt.hasGetFlg");
         addChild(_bar);
         addChild(_scorebg);
         addChild(_cjGetBtn);
         addChild(_cjDesTxt);
         addChild(_cjTitle);
         addChild(_cjScore);
         addChild(_cjGetBg);
         _cjTitle.text = LanguageMgr.GetTranslation("ChristmasCjItem.cjTitle.text");
         _cjGetBg.visible = false;
         _cjGetBg.x = 350;
         _cjGetBg.y = 20;
      }
      
      public function set taskList(param1:Array) : void
      {
         _taskList = param1;
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc4_:ChristmasAchievementsTempInfo = null;
         var _loc1_:int = 0;
         var _loc3_:ChristmasTaskInfo = null;
         var _loc2_:int = 0;
         if(_taskList)
         {
            _loc1_ = int(_taskList.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc4_ = _taskList[_loc2_];
               _loc3_ = model.taskDic[_loc4_.Id];
               if(_loc3_ && !_loc3_.isReward)
               {
                  break;
               }
               _loc2_++;
            }
            _temp = _loc4_;
            _cjDesTxt.htmlText = LanguageMgr.GetTranslation("ChristmasCjItem.cjDesTxt.text",_temp.Describe,_loc3_.data,_temp.Para);
            _cjScore.text = "" + _temp.Score;
            if(_loc3_.data >= _temp.Para)
            {
               _cjGetBtn.enable = true;
            }
            else
            {
               _cjGetBtn.enable = false;
            }
            if(_loc3_.isReward)
            {
               _cjGetBtn.visible = false;
               _cjGetBg.visible = true;
            }
            else
            {
               _cjGetBtn.visible = true;
               _cjGetBg.visible = false;
            }
         }
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      private function initEvent() : void
      {
         _cjGetBtn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _cjGetBtn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_temp)
         {
            ChristmasManager.instance.opRequest(13,_temp.Id);
         }
      }
      
      public function dispose() : void
      {
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         removeEvent();
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_scorebg);
         _scorebg = null;
         ObjectUtils.disposeObject(_cjGetBtn);
         _cjGetBtn = null;
         ObjectUtils.disposeObject(_cjDesTxt);
         _cjDesTxt = null;
         ObjectUtils.disposeObject(_cjTitle);
         _cjTitle = null;
         ObjectUtils.disposeObject(_cjScore);
         _cjScore = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _taskList = null;
      }
   }
}

