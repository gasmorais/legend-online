package crisis.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PlaneCrisisDropInfo;
   import yishi.manager.TempleteManager;
   
   public class PlaneCrisisRewardTipView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _vScrollPanel:ScrollPanel;
      
      private var _spList:Array = [];
      
      private var _desTxt:FilterFrameText;
      
      public function PlaneCrisisRewardTipView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:String = null;
         var _loc7_:Array = null;
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc1_:String = null;
         var _loc8_:Array = null;
         var _loc4_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.rewardStepBox");
         _vScrollPanel = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.rewardStepScrollPanel");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.rewardDesTxt");
         addChild(_bg);
         addChild(_desTxt);
         addChild(_vScrollPanel);
         _vScrollPanel.setView(_vBox);
         _bg.width = 435;
         _bg.height = 325;
         _desTxt.htmlText = LanguageMgr.GetTranslation("planeCrisis.rewardDesTip");
         var _loc6_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("crisis_bonus_show");
         if(_loc6_)
         {
            _loc3_ = _loc6_.ConfigValue;
            _loc7_ = _loc3_.split("|");
            _loc4_ = 0;
            while(_loc4_ < _loc7_.length)
            {
               _loc1_ = _loc7_[_loc4_];
               _loc8_ = _loc1_.split("#");
               _loc5_ = int(_loc8_[0]);
               _loc1_ = _loc8_[1];
               _loc2_ = _loc1_.split("&");
               initRewards(1,_loc5_,_loc2_);
               _loc4_++;
            }
         }
      }
      
      private function initRewards(param1:int, param2:int, param3:Array) : void
      {
         var _loc4_:Array = null;
         var _loc21_:Dictionary = null;
         var _loc20_:String = null;
         var _loc9_:Array = null;
         var _loc18_:int = 0;
         var _loc5_:Array = null;
         var _loc19_:int = 0;
         var _loc7_:FilterFrameText = null;
         var _loc15_:FilterFrameText = null;
         var _loc17_:FilterFrameText = null;
         var _loc8_:String = null;
         var _loc10_:PlaneCrisisDropInfo = null;
         var _loc11_:GoodsTemplateInfo = null;
         var _loc14_:Sprite = null;
         var _loc16_:String = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(param3 != null)
         {
            _loc4_ = TempleteManager.instance.planeCrisisGoodTempCate.getGoodList(param1,param2);
            _loc21_ = new Dictionary();
            for each(var _loc6_:PlaneCrisisDropInfo in _loc4_)
            {
               _loc20_ = _loc6_.para2;
               _loc9_ = _loc21_[_loc20_];
               if(_loc9_ == null)
               {
                  _loc9_ = [];
                  _loc21_[_loc20_] = _loc9_;
               }
               _loc9_.push(_loc6_);
            }
            _loc18_ = int(param3.length);
            _loc8_ = "";
            _vBox.beginChanges();
            _loc12_ = 0;
            while(_loc12_ < _loc18_)
            {
               _loc16_ = param3[_loc12_];
               _loc14_ = new Sprite();
               _loc7_ = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.rewardStepNameTxt");
               _loc15_ = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.rewardStepScoreTxt");
               _loc17_ = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.rewardStepContentTxt");
               _loc14_.addChild(_loc7_);
               _loc14_.addChild(_loc15_);
               _loc14_.addChild(_loc17_);
               _vBox.addChild(_loc14_);
               _spList.push(_loc14_);
               _loc5_ = _loc21_[_loc16_];
               _loc19_ = 0;
               if(_loc5_ != null)
               {
                  _loc19_ = int(_loc5_.length);
               }
               if(_loc12_ == 0)
               {
                  _loc7_.text = LanguageMgr.GetTranslation("planeCrisis.DiffName" + param2);
               }
               if(_loc16_.indexOf(",") != -1)
               {
                  _loc16_ = _loc16_.replace(",","-");
                  if(_loc19_ == 0)
                  {
                     _loc16_ = LanguageMgr.GetTranslation("planeCriris.rewardScoreStep",_loc16_) + LanguageMgr.GetTranslation("planeCrisis.downTip");
                  }
                  else
                  {
                     _loc16_ = LanguageMgr.GetTranslation("planeCriris.rewardScoreStep",_loc16_);
                  }
               }
               else
               {
                  _loc16_ = LanguageMgr.GetTranslation("planeCriris.rewardScoreStep",_loc16_) + LanguageMgr.GetTranslation("planeCrisis.UpTip");
               }
               _loc15_.text = _loc16_;
               _loc8_ = "";
               _loc13_ = 0;
               while(_loc13_ < _loc19_)
               {
                  _loc10_ = _loc5_[_loc13_];
                  if(_loc10_)
                  {
                     _loc11_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc10_.itemId);
                  }
                  if(_loc11_)
                  {
                     _loc8_ += _loc11_.TemplateName + "*" + _loc10_.count + "\n";
                  }
                  _loc13_++;
               }
               _loc17_.htmlText = _loc8_;
               _loc12_++;
            }
            _vBox.commitChanges();
            _vScrollPanel.invalidateViewport();
         }
      }
      
      private function sortFun(param1:String, param2:String) : int
      {
         var _loc3_:Array = param1.split(",");
         var _loc5_:Array = param2.split(",");
         if(_loc3_.length == 1)
         {
            _loc3_.unshift(0);
         }
         if(_loc5_.length == 1)
         {
            _loc5_.unshift(0);
         }
         var _loc6_:int = int(_loc3_[1]);
         var _loc4_:int = int(_loc5_[1]);
         if(_loc6_ > _loc4_)
         {
            return 1;
         }
         if(_loc6_ == _loc4_)
         {
            return 0;
         }
         return -1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         for each(var _loc1_:Sprite in _spList)
         {
            ObjectUtils.disposeAllChildren(_loc1_);
         }
         _spList = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_vScrollPanel);
         _vScrollPanel = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         super.dispose();
      }
   }
}

