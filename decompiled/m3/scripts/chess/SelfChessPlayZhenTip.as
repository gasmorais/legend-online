package chess
{
   import chess.item.SelfChessIconItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.datas.templates.SelfChessBuffTempInfo;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.BaseTip;
   
   public class SelfChessPlayZhenTip extends BaseTip
   {
      
      public var _tip2DesTxt:FilterFrameText;
      
      public var _tip2Title1:FilterFrameText;
      
      public var _tip2Title2:FilterFrameText;
      
      private var _line:Bitmap;
      
      private var _battlePanel:SimpleTileList;
      
      private var _waitPanel:SimpleTileList;
      
      private var _battleList:Array = [];
      
      private var _waitList:Array = [];
      
      public function SelfChessPlayZhenTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:SelfChessIconItem = null;
         var _loc2_:int = 0;
         super.init();
         _tip2DesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tip2DesTxt");
         _tip2Title1 = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tip2Title1");
         _tip2Title2 = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tip2Title2");
         _line = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _battlePanel = ComponentFactory.Instance.creatCustomObject("playTipBattle.SimpleTileList",[4]);
         _waitPanel = ComponentFactory.Instance.creatCustomObject("playTipWait.SimpleTileList",[4]);
         addChild(_tip2DesTxt);
         addChild(_tip2Title1);
         addChild(_tip2Title2);
         addChild(_line);
         addChild(_battlePanel);
         addChild(_waitPanel);
         _battlePanel.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new SelfChessIconItem();
            _battlePanel.addChild(_loc1_);
            _battleList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _battlePanel.commitChanges();
         _waitPanel.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new SelfChessIconItem();
            _waitPanel.addChild(_loc1_);
            _waitList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _waitPanel.commitChanges();
         _line.y = 52;
         _line.width = _bg.width = 227;
         _bg.height = 300;
         _tip2Title1.text = LanguageMgr.GetTranslation("selfchess.team.battle");
         _tip2Title2.text = LanguageMgr.GetTranslation("selfchess.team.wait");
      }
      
      override protected function updateTransform() : void
      {
         var _loc4_:Array = null;
         var _loc2_:SelfChessIconItem = null;
         var _loc3_:SelfChessTempInfo = null;
         var _loc7_:int = 0;
         var _loc22_:Dictionary = null;
         var _loc18_:Array = null;
         var _loc16_:int = 0;
         var _loc14_:int = 0;
         var _loc19_:int = 0;
         var _loc11_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:Array = null;
         var _loc1_:Array = null;
         var _loc15_:String = null;
         var _loc10_:SelfChessBuffTempInfo = null;
         var _loc5_:int = 0;
         var _loc13_:int = 0;
         var _loc6_:Array = null;
         var _loc21_:SelfChessPlayerInfo = tipData as SelfChessPlayerInfo;
         if(_loc21_)
         {
            _loc4_ = _loc21_.battleAry;
            _loc22_ = new Dictionary();
            _loc11_ = [];
            _loc8_ = 0;
            while(_loc8_ < 8)
            {
               _loc2_ = _battleList[_loc8_];
               _loc7_ = int(_loc4_[_loc8_]);
               _loc2_.heroId = _loc7_;
               if(_loc7_ != 0)
               {
                  _loc3_ = TempleteManager.instance.selfChessTempCate.getTempById(_loc7_);
                  if(_loc3_)
                  {
                     if(_loc11_.indexOf(_loc3_.MasterType) == -1)
                     {
                        _loc11_.push(_loc3_.MasterType);
                        _loc18_ = _loc3_.Job.split(",");
                        _loc16_ = int(_loc18_.length);
                        _loc9_ = 0;
                        while(_loc9_ < _loc16_)
                        {
                           _loc14_ = int(_loc18_[_loc9_]);
                           _loc19_ = int(_loc22_[_loc14_]);
                           _loc19_++;
                           _loc22_[_loc14_] = _loc19_;
                           _loc9_++;
                        }
                     }
                  }
               }
               _loc8_++;
            }
            _loc12_ = [];
            for(var _loc20_:String in _loc22_)
            {
               _loc12_.push(int(_loc20_));
            }
            _loc12_.sort(16);
            _loc15_ = "";
            _loc13_ = 0;
            if(_loc12_)
            {
               _loc13_ = 20 * Math.ceil(_loc12_.length / 2);
            }
            for each(var _loc17_:int in _loc12_)
            {
               _loc1_ = TempleteManager.instance.selfChessBuffTempCate.getTempJobList(_loc17_);
               _loc10_ = _loc1_[0];
               if(_loc10_)
               {
                  if(++_loc5_ % 2 == 0)
                  {
                     _loc15_ = _loc15_ + (_loc22_[_loc17_] + "-" + _loc10_.TemplateName) + "\n";
                  }
                  else
                  {
                     _loc15_ = _loc15_ + (_loc22_[_loc17_] + "-" + _loc10_.TemplateName) + "    ";
                  }
               }
            }
            _tip2DesTxt.height = _loc13_;
            _tip2DesTxt.htmlText = _loc15_;
            _line.y = _tip2DesTxt.y + _loc13_ + 5;
            _tip2Title1.y = _line.y + 5;
            _battlePanel.y = _tip2Title1.y + 22;
            _tip2Title2.y = _battlePanel.y + _battlePanel.height + 5;
            _waitPanel.y = _tip2Title2.y + 22;
            _bg.height = _waitPanel.y + _waitPanel.height + 5;
            _loc6_ = _loc21_.alternateAry;
            _loc8_ = 0;
            while(_loc8_ < 8)
            {
               _loc2_ = _waitList[_loc8_];
               _loc2_.heroId = int(_loc6_[_loc8_]);
               _loc8_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_tip2DesTxt);
         _tip2DesTxt = null;
         ObjectUtils.disposeObject(_tip2Title1);
         _tip2Title1 = null;
         ObjectUtils.disposeObject(_tip2Title2);
         _tip2Title2 = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_battlePanel);
         _battlePanel = null;
         ObjectUtils.disposeObject(_waitPanel);
         _waitPanel = null;
         super.dispose();
         _waitList = null;
         _battleList = null;
      }
   }
}

